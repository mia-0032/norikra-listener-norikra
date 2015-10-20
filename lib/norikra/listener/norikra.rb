require "norikra/listener"
require "norikra-client"

module Norikra
  module Listener
    class NorikraForwarder < Norikra::Listener::Base
      def self.label
        "NORIKRA"
      end

      def self.parse_argument(argument, query_name)
        addr, target = argument.split(',', 2)
        target = query_name unless target
        @target = target

        host, port_str = addr.split(':', 2)
        raise Norikra::ArgumentError, "host is not specified" if host.empty?
        port = port_str ? port_str.to_i : 26571

        [target, host, port]
      end

      def initialize(argument, query_name, query_group)
        super
        @target, host, port = NorikraForwarder::parse_argument(argument, query_name)
        @client = Norikra::Client.new(host, port)
      end

      def process_async(events)
        if events.respond_to?(:map)
          events = events.map{|t, e| e }
          @client.send(@target, events)
        end
      end
    end
  end
end
