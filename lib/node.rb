class Node
  attr_reader :child_nodes

  attr_accessor :is_word,
                :child_nodes,
                :checked

  def initialize(is_word = false, checked = false)
    @child_nodes=Hash.new
    @is_word = is_word
    @checked = checked
  end

end
