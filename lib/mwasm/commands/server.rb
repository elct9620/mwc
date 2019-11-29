# frozen_string_literal: true

require 'rack'

require 'mwasm/utils/command'
require 'mwasm/server'
require 'mwasm'

module Mwasm
  module Commands
    # :nodoc:
    class Server < Thor::Group
      include Utils::Command

      name 'server'
      description 'serve compiled wasm'
      add_option :port, type: :numeric, default: 8080

      def boot
        Rack::Handler
          .default
          .run(Mwasm::Server.new, Port: parent_options['port'])
      end
    end
  end
end
