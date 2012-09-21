module Sprockets
  class AssetAttributes
    def extensions
      @extensions ||= @pathname.basename.to_s.scan(/\.[^.]+/)
      Inspect::Template::Namespace.value.each { |ext|
        @extensions.push(".inspect") if @pathname.to_s[ext] != nil and not @extensions.include? ".inspect"
      }
      @extensions
    end
  end
end

