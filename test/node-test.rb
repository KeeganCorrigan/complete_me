require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def test_instance_of
    node = Node.new

    assert_instance_of Node, node
  end

  def test_not_a_word_by_default
    node=Node.new
    refute node.is_word
  end

  def test_it_can_be_made_a_word
    node=Node.new(true)

    assert node.is_word
  end
end
