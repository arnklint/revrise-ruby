require 'spec_helper'

describe RevRise do
  it "raises ArgumentError when initialized with no options" do
    lambda { RevRise.new }.should raise_error(ArgumentError)
  end


end
