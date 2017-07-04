require_relative 'event_streams/event_streams'

module ChartJS

	class EventStream 

		def to_html(source: @path, chart: @chart)
			str = ""
      str << "<script>\n"
      str << "var source = new EventSource('#{path}');\n"
      str << "var json;\n"
      str << @counter if @counter
      str << @push.to_s if @push
		  str << @pop     if @pop
      str << @raw     if @raw
      str << "</script>\n"
		end

    def push(dataset: 0, chart: @chart, &block)
      @push = EventStreams.push(dataset: dataset, chart: @chart, &block)
    end
   
    #def count(dataset: 0, chart: @chart, &block)


    #end

    def raw(chart: @chart, str: nil, file: nil, without_source: true, update: true)
      @raw = ""
      @raw = @raw + "source.onmessage = function(e) { json = JSON.parse(e.data);"
      return @raw if str.nil? and file.nil?
      @raw = @raw + str unless str.nil?
      @raw = @raw + File.readlines(file) unless file.nil?
      @rar = @raw + "#{chart}.update();" if update
      @raw = @raw + "};"
    end
    
    def counter(dataset:, chart: @chart, counter: "counter")
      str = ""
      str << "var #{counter} = 0;\n"
			str << "source.onmessage = function(e) { #{counter} += 1 };\n"
    end

    def chart(chart_obj = nil)
      return @chart if chart_obj.nil?
      @chart = chart_obj
    end

		def initialize(path, chart)
      @push = nil
      chart(chart)
			path(path)
      build(block) if block_given?
		end
  
    def build(&block)
			instance_eval(&block)
      self
    end

		def path(value = nil)
			return @path if value.nil?
			@path = value
		end

	end

end
