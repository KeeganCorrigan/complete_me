require "./lib/node"
require 'pry'

class CompleteMe
  attr_reader :root,
              :count

  def initialize
    @root = Node.new
    @count = 0
  end

  def insert(node = @root, word)

    if word.length == 0 # word complete, base case
      node.is_word = true # refactor to nil if not a word...?
      @count += 1
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

  


end
