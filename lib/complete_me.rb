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

  def count(current_node = @root, total = 0)
    keys = current_node.child_nodes.keys  
    binding.pry
    if current_node.is_word && keys.length == 0 # leaf, break statement
      total += 1
      return total
    elsif current_node.is_word # a word, but more branches below
      total += 1
      keys.each do |key| # start a recursive call through every branch below
        return count(current_node.child_nodes[key], total)
      end
    else
      keys.each do |key| # start a recursive call through every branch below
        return count(current_node.child_nodes[key], total)
      end
    end
  end
end
