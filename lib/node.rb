class Node

  attr_accessor :is_word

  def initialize(is_word = false)
    child_nodes=Hash.new
    @is_word = is_word
  end

end
