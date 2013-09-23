# -*- encoding: utf-8 -*-
require "spec_helper"

module RevRise
  describe 'event tracking' do
    it "encodes a json event" do
      r = RevRise::Base.new('x')

      r.track 'mah name', {
        :prop1 => "hej eller ä du go i höveet eller",
        :yo_mo => "kekke"
      }

    end
  end
end
