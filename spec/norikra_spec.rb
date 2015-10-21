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

  describe '.process_async' do
    it 'send no events' do
      client_mock = double('Norikra client')
      expect(client_mock).to_not receive(:send)
      expect(Norikra::Client).to receive(:new).with('localhost', 26571).and_return(client_mock)
      obj = Norikra::Listener::NorikraForwarder.new('localhost', 'test_query', '')
      obj.process_async(nil)
    end

    it 'send events' do
      expected = [
          {"n1" => 8, "s" => "eight"},
          {"n1" => 9, "s" => "nine"},
          {"n1" => 10, "s" => "ten"}
      ]

      client_mock = double('Norikra client')
      expect(client_mock).to receive(:send).with("test_query", expected)
      expect(Norikra::Client).to receive(:new).with('localhost', 26571).and_return(client_mock)
      obj = Norikra::Listener::NorikraForwarder.new('localhost', 'test_query', '')
      obj.process_async([
          [1445363165, {"n1" => 8, "s" => "eight"}],
          [1445363166, {"n1" => 9, "s" => "nine"}],
          [1445363167, {"n1" => 10, "s" => "ten"}]
      ])
    end
  end
end
