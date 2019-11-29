# frozen_string_literal: true

require 'mwc/utils/option'

module Mwc
  module Options
    # The mruby preference
    class MRuby
      include Utils::Option

      option :version
      option :path, type: :path, default: 'vendor/mruby'
    end
  end
end
