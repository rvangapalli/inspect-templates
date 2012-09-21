module Sprockets
  class AssetAttributes
    def extensions
      @extensions ||= @pathname.basename.to_s.scan(/\.[^.]+/)
      Sprockets::Inspect::Template::Namespace.value.each { |ext|
        @extensions.push(".inspect") if @pathname.to_s[ext] != nil and not @extensions.include? ".inspect"
      }
      @extensions
    end
  end

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
          filename=(scope.pathname.to_s.split /\//).last
          parts=(scope.logical_path.split /\//)
          parts.pop
          parts.push filename
          relative_path=parts.join "/"
          "<inspect class='inspect' data-render='client' data-path='#{scope.logical_path}'>#{data}</inspect>"
        end
      end

    end
  end
end

Sprockets::register_engine '.inspect', Sprockets::Inspect::Template::Processor