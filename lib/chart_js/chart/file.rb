require_relative "dataset.rb"

module ChartJS

  class SaveFile 

    def initialize(path, html: false)
      path(path)
      @html = html if html
    end
   
    def path(value = nil)
      return @path if value.nil?
      @path = value
    end

    def save!(path: @path, html: @html)
      File.open(path, "w") do |file|
        file.write(html)
        file.close
      end
    end

  end

end
