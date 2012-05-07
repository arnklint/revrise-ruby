require "revrise"
require "yaml"
require "vcr"

def fixtures(fixture)
  @@fixtures ||= load_fixtures
  @@fixtures[fixture]
end

def load_fixtures
  fixtures = {}

  Dir['spec/fixtures/*.yml'].each do |file|
    name = File.basename(file, File.extname(file)).to_sym
    fixtures[name] = YAML::load(File.open(file).read)
  end

  fixtures
end

VCR.config do |c|
  c.default_cassette_options = {:match_requests_on => [:method, :uri, :body]}
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.stub_with :webmock
end
