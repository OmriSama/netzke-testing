require "netzke/testing/version"
require "netzke/testing/helpers"
require "active_support/core_ext"

if defined? ::Rails
  require "netzke/testing/engine"
end

module Netzke
  module Testing
    # Path to the root of your JS specs (which are part of integration tests)
    mattr_accessor :spec_root

    # JS paths that should be included in the testing template
    mattr_accessor :custom_js
    @@custom_js = []

    # Timeout (seconds) for JS spec execution
    mattr_accessor :js_timeout
    @@js_timeout = 5

    def self.rspec_init(rspec_config)
      @@spec_root = Pathname.new(caller.first).join("../..")
      rspec_config.include(Netzke::Testing::Helpers)
    end

    def self.setup
      yield self
    end
  end
end
