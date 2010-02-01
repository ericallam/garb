$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'
require 'shoulda'
require 'minitest/unit'
require 'mocha'

require File.dirname(__FILE__) + '/../lib/garb'

class MiniTest::Unit::TestCase
  
  include Shoulda::InstanceMethods
  extend Shoulda::ClassMethods
  include Shoulda::Assertions
  extend Shoulda::Macros
  include Shoulda::Helpers

  def read_fixture(filename)
    File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
  end
  
end

MiniTest::Unit.autorun