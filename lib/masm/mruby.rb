# frozen_string_literal: true

require 'masm'

module Masm
  # MRuby config
  class MRuby
    attr_accessor :version

    def path
      Masm.root.join('vendor/mruby')
    end
  end
end
