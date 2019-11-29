# frozen_string_literal: true

require 'rack'

require 'masm/utils/command'
require 'masm/server'
require 'masm'

module Masm
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
          .run(Masm::Server.new, Port: parent_options['port'])
      end
    end
  end
end
