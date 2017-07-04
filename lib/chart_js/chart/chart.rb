require "json"
require "securerandom"
require_relative "data.rb"
require_relative "opts.rb"
require_relative "file.rb"
require_relative "event_stream.rb"

module ChartJS

  class Chart

    def initialize(&block)
      @type      = nil
      @data      = nil
      @opts      = nil
      @file      = false
      @stream    = false
      @chart_obj = 'chart' + SecureRandom.uuid.gsub("-","")
      build(&block) if block_given?
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
      case type
      when 'pie'
        { type: @type, data: @data.to_h(:pie), options: @opts.to_h }
      when 'doughnut'
        { type: @type, data: @data.to_h(:pie), options: @opts.to_h }
      when 'line'
        data = @data.to_h(false)
        data['datasets'].each do |set|
          set['fill'] = false unless set['fill']
        end  
        #data['fill'] = false unless data['fill']
        { type: @type, data: data, options: @opts.to_h }
      else
        { type: @type, data: @data.to_h(false), options: @opts.to_h }
      end
    end

    def to_json(type = :pretty)
      return JSON.pretty_generate(to_h) if type == :pretty
      to_h.to_json
    end

    def type(value = nil)
      return @type if value.nil?
      @type = value
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

    def chart_obj(value = nil)
      return @chart_obj if value.nil?
      @chart_obj = value
    end

    def random_id(force: false)
      return @id unless @id.nil? or force 
      @id = SecureRandom.uuid
    end


    def event_stream(path, chart: chart_obj, &block)
      @stream = EventStream.new(path, chart)
      @stream.build(&block) if block_given?
    end

    def script(config: to_json, id: random_id, chart: chart_obj)
      "<script>
          var config = #{config}
          var ctx = document.getElementById(\"#{id}\").getContext(\"2d\");
          var #{chart} = new Chart(ctx, config);
      </script>" 
    end

    def to_html(width: "60%", heigth: width, head: true, cdn: head, version: "2.6.0", body: true, id: random_id, script: true, chart: chart_obj, stream: true)
      str = []
      if cdn
        str << "<head>#{cdn(version: version)}</head>" 
      end
      str << "<body>" if body
      str << "<div id=\"canvas-holder\" style=\"width:#{width} heigth:#{heigth}\">"
      str << "<canvas id=\"#{id}\"/>"
      str << "</div>"
      str << "</body>" if body
      str << script(id: id, chart: chart) if script
      str << @stream.to_html if @stream && stream 
      str.join("\n")
    end

    def file(path, &block)
      @file = path
      @file_block = block
    end

  end

end
