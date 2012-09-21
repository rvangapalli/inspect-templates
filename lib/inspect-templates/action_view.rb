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