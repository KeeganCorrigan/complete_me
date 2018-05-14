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
    # skip
    complete = CompleteMe.new

    dictionary = File.read("/usr/share/dict/words")

    complete.populate(dictionary)

    assert_equal 235886, complete.count

  end

  def test_suggest
    complete = CompleteMe.new
    complete.insert("pizza")
    complete.insert("pizzaz")
    complete.insert("pizzeria")
    complete.insert("duck")

    assert_equal ["pizza", "pizzaz", "pizzeria"], complete.suggest("piz")
  end

  def test_delete
    complete = CompleteMe.new
    complete.insert("pizza")
    complete.insert("pizzaz")
    complete.insert("pizzeria")
    complete.insert("duck")

    assert_equal ["pizza", "pizzaz", "pizzeria"], complete.suggest("piz")

    complete.delete("pizzaz")

    assert_equal ["pizza", "pizzeria"], complete.suggest("piz")
    assert_nil complete.root.child_nodes['p'].child_nodes['i'].child_nodes['z'].child_nodes['z'].child_nodes['a'].child_nodes['z']
  end

  def test_select
    complete = CompleteMe.new
    complete.insert("pizza")
    complete.insert("pizzaz")
    complete.insert("pizzeria")
    complete.insert("duck")
    node_to_test = complete.root.child_nodes['d'].child_nodes['u'].child_nodes['c'].child_nodes['k']

    first_hash = Hash.new
    assert_equal first_hash, node_to_test.weight

    complete.select('du', 'duck')

    second_hash = Hash.new
    second_hash["du"] = 1

    assert_equal second_hash, node_to_test.weight
  end

  def test_weight
    complete = CompleteMe.new
    complete.insert("pizza")
    complete.insert("pizzaz")
    complete.insert("pizzeria")
    complete.insert("duck")

    assert_equal ["pizza", "pizzaz", "pizzeria"], complete.suggest("piz")

    complete.select('piz', 'pizzaz')

    assert_equal ["pizzaz", "pizza", "pizzeria"], complete.suggest("piz")
  end
end
