# frozen_string_literal: true

require 'mwc'

module Mwc
  # MRuby config
  class MRuby
    attr_accessor :version

    def path
      Mwc.root.join('vendor/mruby')
    end
  end
end
