require "json"
require "securerandom"
require_relative "data.rb"
require_relative "opts.rb"
require_relative "file.rb"

module ChartJS

  class LineChart

    def initialize(&block)
      @type = "line"
      @data = nil
      @opts = nil
      @file = false
      build(&block)
    end

    def build(&block)
      instance_eval(&block)
      if @file
        f = SaveFile.new(@file, html: to_html)
        f.save!
      end
      self
    end

    def to_h
      { type: @type, data: @data.to_h, options: @opts.to_h }
    end

    def to_json(type = :pretty)
      return JSON.pretty_generate(to_h) if type == :pretty
      to_h.to_json
    end

    def data(&block)
      return @data unless block_given?
      @data = Data.new.build(&block)
    end

    def opts(&block)
      return @opts unless block_given?
      @opts = Opts.new.build(&block)
    end

    def cdn(version: "2.6.0", min: true)
      if min
        "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/Chart.js/#{version}/Chart.min.js\"></script>"
      else
        "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/Chart.js/#{version}/Chart.js\"></script>"
      end
    end

    def random_color
      "##{SecureRandom.hex(3)}"
    end

    def random_id
      SecureRandom.uuid
    end

    def script(config: to_json, id: random_id, chart_name: id)
      "<script>
          var config = #{config};
          var #{chart_name.gsub("-","_")};
          window.onload = function() {
            var ctx = document.getElementById(\"#{id}\").getContext(\"2d\");
            var #{chart_name.gsub("-","_")} = new Chart(ctx, config);
          };
      </script>" 
    end

    def to_html(width: "60%", heigth: width, head: true, cdn: head, version: "2.6.0", body: true, id: random_id, script: true, chart_name: "line_chart")
      str = []
      if cdn
        str << "<head>#{cdn(version: version)}</head>" 
      end
      str << "<body>" if body
      str << "<div id=\"canvas-holder\" style=\"width:#{width} heigth:#{heigth}\">"
      str << "<canvas id=\"#{id}\"/>"
      str << "</div>"
      str << "</body>" if body
      str << script(id: id, chart_name: chart_name) if script
      str.join("\n")
    end

    def file(path, &block)
      @file = path
      @file_block = block
    end

  end

end
