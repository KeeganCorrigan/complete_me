require "minitest/autorun"
require "minitest/pride"
require "./lib/complete_me.rb"

class CompleteMeTest < Minitest::Test

  def test_exists
    complete = CompleteMe.new

    assert_instance_of CompleteMe, complete
  end

  def test_root_exists
    complete = CompleteMe.new

    assert_instance_of Node, complete.root
  end

  def test_insert
    complete = CompleteMe.new
    test_hash = Hash.new
    # test_node = Node.new()

    assert_equal test_hash, complete.root.child_nodes

    complete.insert("pizza")

    refute_nil complete.root.child_nodes["p"]
    refute_nil complete.root.child_nodes["p"].child_nodes["i"]

    refute_equal true, complete.root.child_nodes["p"].child_nodes["i"].child_nodes["z"].child_nodes["z"].is_word
    assert_equal ["i"], complete.root.child_nodes["p"].child_nodes.keys
    assert_equal true, complete.root.child_nodes["p"].child_nodes["i"].child_nodes["z"].child_nodes["z"].child_nodes["a"].is_word

  end

end
