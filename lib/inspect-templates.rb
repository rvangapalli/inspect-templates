require "inspect-templates/version"
require "tilt"
require "sprockets"
require "action_view"


module ActionView
  # = Action View Template
  class Template
    def render(view, locals, buffer=nil, &block)
      ActiveSupport::Notifications.instrument("!render_template.action_view", :virtual_path => @virtual_path) do
        compile!(view)
        res=view.send(method_name, locals, buffer, &block)
        "<inspect class='inspect'  data-render='server' data-path='#{@virtual_path}'>#{res}</inspect>".html_safe
      end
    rescue Exception => e
      handle_render_error(view, e)
    end
  end
end

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

