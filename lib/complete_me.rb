require "./lib/node"
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


end
