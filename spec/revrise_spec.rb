require 'spec_helper'

describe RevRise do
  it "raises ArgumentError when initialized with no options" do
    lambda { RevRise.new }.should raise_error(ArgumentError)
  end

  context "initialized with auth token and e-mail" do
    subject do
      RevRise.new(:auth_token => "x", :auth_email => "jonas.arnklint@revrise.com")
    end

    it "returns auth token and email" do
      subject.auth_token.should == "x"
      subject.auth_email.should == "jonas.arnklint@revrise.com"
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

    [:get, :delete, :head].each do |method|
      describe "##{method}" do
        it "raises an error if request was not successful" do
          stub_request(method, "http://api.revrise.com/core/projects").
            with(:query => {:format => "json", :auth_token => "x", :auth_email => "j@revrise.com"}).
            to_return(:status => 402, :body => "{'error': 'wrong something'}")

          lambda {subject.send(method, "/core/projects")}.should raise_error(RevRise::ResponseError)
        end
      end
    end
  end

end
