require "./lib/node"
require 'pry'

class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(node = @root, word)
    if word.length == 0
      node.is_word = true
    else
      word_array = word.chars
      next_char=word_array[0]
      word_array.shift
      if node.child_nodes[next_char] == nil #creates a new branch if one doesn't alrady exist
        node.child_nodes[next_char] = Node.new
      end
      insert(node.child_nodes[next_char], word_array.join)
    end
  end

  def suggest(node = @root, current_word = "", fragment)
    children = node.child_nodes.keys
    if fragment.length != 0
      next_char=fragment[0]
      if node.child_nodes[next_char] != nil
        fragment_array = fragment.chars
        fragment_array.shift
        return suggest(node.child_nodes[next_char], current_word+next_char, fragment_array.join)
      end
    else
      words=[]
      if node.is_word
        words.push(current_word)
      end
      children.each do | child |
        words += suggest(node.child_nodes[child], current_word + child, fragment)
      end
      return words
    end
  end

end
