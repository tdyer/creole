# pick up minitest from gem, not default one in 1.9.x
require 'rubygems' 
gem 'minitest'

# always need this
require 'minitest/autorun'
# require 'minitest/spec'

# see minitest source lib/minitest/spec.rb for current set of matchers
describe "TestTrue" do
  subject{ true}
  # old way
  # before do
  #    @subject = true
  #  end

  describe "true" do
    it "is true" do
      # like RSpec should
      # @subject.must_be true
      subject.must_equal true
      

      # like RSpec should_not
      # @subject.wont_be false
      subject.wont_equal false
    end
  end

  
end

describe "TestString" do
  let(:somestring) { "somestring"}
  let(:emptystring) { ""}

  describe "assertions" do
    it "correct" do
      emptystring.must_be :empty?
      somestring.wont_be :empty?
      32.wont_be :<, 31

      emptystring.wont_respond_to :foo
      emptystring.must_respond_to :size
      emptystring.wont_be_nil

      somestring.must_equal "somestring"
      somestring.wont_be_same_as "somestring"
      somestring.wont_equal "xxx"
      somestring.wont_match /abc/
      somestring.must_match /mestr/

      somestring.wont_be_kind_of Fixnum
    end
  end
end


describe Array do
  let(:array_1) { [1, 'twenty', 35] }
  let(:array_empty) { [] }

  describe "assertions" do
    it "should be empty" do
      array_1.wont_be :empty?
      array_1.size.must_equal 3
    end

    it "should include" do
      array_1.must_include 35
      array_1.must_include "twenty"
    end
  end
end

