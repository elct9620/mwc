# frozen_string_literal: true

require 'rack'

require 'mwc/utils/command'
require 'mwc/server'
require 'mwc'

module Mwc
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
          .run(Mwc::Server.new, Port: parent_options['port'])
      end
    end
  end
end
