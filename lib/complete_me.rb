require_relative "node"
require 'pry'

class CompleteMe
  attr_reader :root,
              :total_words

  def initialize
    @root = Node.new
    @total_words = 0
  end

  def insert(node = @root, word)

    if word.length == 0 # word complete, base case
      node.is_word = true # refactor to nil if not a word...?
    else
      word_array = word.chars
      next_char = word_array[0]
      word_array.shift
      if node.child_nodes[next_char] == nil #creates a new branch if one doesn't already exist
        node.child_nodes[next_char] = Node.new
      end

      insert(node.child_nodes[next_char], word_array.join)
    end
  end

  def populate(file)
    file.each_line do |word|
      if word.length > 0
        insert(word.chomp)
      end
    end
  end

  def count(current_node = @root)
    if current_node.is_word && current_node.checked == false
      @total_words += 1
      current_node.checked = true
    end
    current_node.child_nodes.each_key do |key|
      count(current_node.child_nodes[key])
    end
    return @total_words
  end

  def suggest(fragment)
    weighted_array = recursive_suggest(@root, "", fragment)
    return_array = Array.new
    weighted_array.sort_by! do |word|
      word[0] * -1
    end
    weighted_array.each do |word|
      return_array.push(word[1])
    end

    return_array
  end

  def recursive_suggest(node = @root, current_word = "", fragment)
    children = node.child_nodes.keys
    if fragment.length != 0
      next_char=fragment[0]
      if node.child_nodes[next_char] != nil
        fragment_array = fragment.chars
        fragment_array.shift
        return recursive_suggest(node.child_nodes[next_char], current_word+next_char, fragment_array.join)
      end
    else
      words=[]
      if node.is_word
        words.push([node.weight, current_word])
      end
      children.each do | child |
        words+=recursive_suggest(node.child_nodes[child], current_word + child, fragment)
      end
      return words
    end
  end

  def delete(node = @root, current_word = "", word)
    if current_word == word
      node.is_word = false
      if node.child_nodes.empty?
        return true
      end
    else
      next_char = word[current_word.length]
      destruct = delete(node.child_nodes[next_char], current_word+next_char, word)
      if destruct
        node.child_nodes.delete(next_char)
      end
      if node.is_word
        destruct=false
      end

      return destruct
    end
  end

  def select(substring, word, node = @root, current_word = "" )
    if current_word == word
      node.weight += 1
    else
      next_char = word[current_word.length]
      select(substring, word, node.child_nodes[next_char], current_word + next_char)
    end
  end
end
