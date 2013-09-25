require 'spec_helper'

describe RevRise do
  it "raises ArgumentError when initialized with no options" do
    lambda { RevRise.new }.should raise_error(ArgumentError)
  end

  context "initialized with auth token and e-mail" do
    subject do
      RevRise.new(:auth_token => "x", :auth_email => "j@revrise.com")
    end

    it "returns auth token and email" do
      subject.auth_token.should == "x"
      subject.auth_email.should == "j@revrise.com"
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

    # , :delete, :head
    [:get].each do |method|
      describe "##{method}" do
        it "wraps the response object in a hash" do
          stub_request(method, "https://api.revrise.com/core/projects/123").
            with(:query => {:format => "json", :auth_token => "x", :auth_email => "j@revrise.com"}).
            to_return(:body => '{"name": "mah project"}', :headers => {:content_type => "application/json"})

          subject.send(method, '/core/projects/123').should be_an_instance_of RevRise::HashResponseWrapper
        end

        it "wraps the response object in an array hashie object" do
          stub_request(method, "https://api.revrise.com/core/projects").
            with(:query => {:format => "json", :auth_token => "x", :auth_email => "j@revrise.com"}).
            to_return(:body => '[{"name": "mah project"}]', :headers => {:content_type => "application/json"})

          subject.send(method, '/core/projects').should be_an_instance_of RevRise::ArrayResponseWrapper
        end

        it "sends a user agent header" do
          stub_request(method, "https://api.revrise.com/core/projects").
            with(:query => {:format => "json", :auth_token => "x", :auth_email => "j@revrise.com"})

          subject.send(method, '/core/projects')
          WebMock.last_request.headers["User-Agent"].should == "RevRise Ruby Wrapper #{RevRise::VERSION}"
        end
      end
    end
  end
end
