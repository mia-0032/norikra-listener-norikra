require "norikra/listener"
require "norikra-client"

module Norikra
  module Listener
    class NorikraForwarder < Norikra::Listener::Base
      def self.label
        "NORIKRA"
      end

      def initialize(argument, query_name, query_group)
        super
        addr, target = argument.split(',', 2)
        target = query_name unless target
        @target = target

        host, port_str = addr.split(':', 2)
        raise Norikra::ArgumentError, "host is not specified" unless host
        port = port_str ? port_str.to_i : 26571

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
