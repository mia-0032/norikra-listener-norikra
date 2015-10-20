# coding: utf-8

require 'norikra-listener-norikra'
require 'norikra/listener_spec_helper'

describe Norikra::Listener::NorikraForwarder do
  describe '.label' do
    it 'returns "NORIKRA"' do
      expect(Norikra::Listener::NorikraForwarder.label).to eql('NORIKRA')
    end
  end

  describe '.parse_argument' do
    it 'only host specified' do
      expect do
          Norikra::Listener::NorikraForwarder.parse_argument(':1', 'test_query')
      end.to raise_error(Norikra::ArgumentError, 'host is not specified')
    end

    it 'only host specified' do
      expect(
          Norikra::Listener::NorikraForwarder.parse_argument('localhost', 'test_query')
      ).to eql(['test_query', 'localhost', 26571])
    end

    it 'target is not specified' do
      expect(
          Norikra::Listener::NorikraForwarder.parse_argument('localhost:22222', 'test_query')
      ).to eql(['test_query', 'localhost', 22222])
    end

    it 'all are specified' do
      expect(
          Norikra::Listener::NorikraForwarder.parse_argument('localhost:22222,test_target', 'test_query')
      ).to eql(['test_target', 'localhost', 22222])
    end
  end
end
