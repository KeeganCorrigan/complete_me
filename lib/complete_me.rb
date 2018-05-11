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

end
