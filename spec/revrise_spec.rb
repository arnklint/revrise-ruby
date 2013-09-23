require 'spec_helper'

describe RevRise do
  it "raises ArgumentError when initialized with no options" do
    lambda { RevRise.new }.should raise_error(ArgumentError)
  end

  context "initialized with auth token and e-mail" do
    subject do
      RevRise.new(:auth_token => "x", :email => "jonas.arnklint@revrise.com")
    end

    it "returns auth token and email" do
      subject.auth_token.should == "x"
      subject.email.should == "jonas.arnklint@revrise.com"
    end

    describe "#host" do
      it "is revrise.com" do
        subject.host.should == "revrise.com"
      end
    end

    describe "#use_ssl?" do
      it "is true" do
        subject.use_ssl?.should == true
      end
    end

    describe "#api_host" do
      it "is api.revrise.com" do
        subject.api_host.should == "api.revrise.com"
      end
    end
  end

end
