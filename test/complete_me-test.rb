require "minitest/autorun"
require "minitest/pride"
require "./lib/complete_me.rb"

class CompleteMeTest < Minitest::Test
  
  def test_exists
    complete = CompleteMe.new

    assert_instance_of CompleteMe, complete
  end


end

