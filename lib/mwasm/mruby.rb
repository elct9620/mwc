# frozen_string_literal: true

require 'mwasm'

module Mwasm
  # MRuby config
  class MRuby
    attr_accessor :version

    def path
      Mwasm.root.join('vendor/mruby')
    end
  end
end
