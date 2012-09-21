module Inspect
  class Engine < Rails::Engine
  end
  module Template
    class Namespace
      def self.value=(val)
        @@value = val
      end

      def self.value
        @@value  ||= []
      end
    end
    class Processor < Tilt::Template

      def prepare
      end

      def evaluate(scope, locals, &block)
        "<inspect class='inspect' data-render='client' data-path='#{scope.logical_path}'>#{data}</inspect>"
      end
    end

  end
end

Sprockets::register_engine '.inspect', Inspect::Template::Processor