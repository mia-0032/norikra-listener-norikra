# coding: utf-8

require 'norikra-listener-norikra'
require 'norikra/listener_spec_helper'

describe Norikra::Listener::NorikraForwarder do
  describe '.label' do
    it 'returns "NORIKRA"' do
      expect(Norikra::Listener::NorikraForwarder.label).to eql("NORIKRA")
    end
  end
end
