class Node
  attr_reader :child_nodes

  attr_accessor :is_word,
                :child_nodes,
                :weight

  def initialize(is_word = false)
    @child_nodes=Hash.new
    @is_word = is_word
    @weight = {}
  end

end

# comment for circleCI tests - remove
