# frozen_string_literal: true

require 'singleton'
require 'forwardable'
require 'rack'

require 'mwasm'

module Mwasm
  # Static assets server
  class Server
    WASM_RULE = /\.(?:wasm)\z/.freeze
    WASM_HEADER = { 'Content-Type' => 'application/wasm' }.freeze

    def initialize
      @static =
        Rack::Static.new(
          ->(_) { [404, {}, []] },
          root: 'dist', # TODO: Set by config
          index: "#{Mwasm.config.project.name}.html",
          urls: [''],
          header_rules: [
            [WASM_RULE, WASM_HEADER]
          ]
        )
    end

    def call(env)
      @static.call(env)
    end
  end
end
