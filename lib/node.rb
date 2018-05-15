class Node
  attr_reader :child_nodes

  attr_accessor :is_word,
                :child_nodes,
                :checked,
                :weight

  def initialize(is_word = false, checked = false)
    @child_nodes=Hash.new
    @is_word = is_word
    @checked = checked
    @weight = {}
  end

end

# comment for circleCI tests - remove