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


    assert_equal test_hash, complete.root.child_nodes

    complete.insert("pizza")

    refute_nil complete.root.child_nodes["p"]
    refute_nil complete.root.child_nodes["p"].child_nodes["i"]

    refute_equal true, complete.root.child_nodes["p"].child_nodes["i"].child_nodes["z"].child_nodes["z"].is_word
    assert_equal ["i"], complete.root.child_nodes["p"].child_nodes.keys
    assert_equal true, complete.root.child_nodes["p"].child_nodes["i"].child_nodes["z"].child_nodes["z"].child_nodes["a"].is_word

    complete.insert("pize")
    

    assert_equal 2, complete.root.child_nodes["p"].child_nodes["i"].child_nodes["z"].child_nodes.keys.length

    complete.insert("pizooo")

    assert_equal 3, complete.root.child_nodes["p"].child_nodes["i"].child_nodes["z"].child_nodes.keys.length
    
  end

  def test_count
    complete = CompleteMe.new

    complete.insert("pizza")

    assert_equal 1, complete.count

    complete.insert("pize")

    assert_equal 2, complete.count

  end

  def test_populate
    complete = CompleteMe.new

    test_file = File.read("/usr/share/dict/words")

    complete.populate(test_file)

    assert_equal 235886, complete.count
    
  end

end










