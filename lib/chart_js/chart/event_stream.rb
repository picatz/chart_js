
module ChartJS

	class EventStream 

		def to_html(source: @path, chart: @chart)
			str = ""
      str = str + "<script>"
      str = str + "var source = new EventSource('#{path}');"
      str = str + "var json;"
      str = str + @counter if @counter
		  str = str + @push if @push
		  str = str + @pop if @pop
      str = str + @raw if @raw
      str = str + "</script>"
		end

    def push(dataset: 0, chart: @chart, data: true, labels: true)
      str = ""
			str = str + "source.onmessage = function(e) { \njson = JSON.parse(e.data);\n"
      str = str + "#{chart}.data.datasets[#{dataset}].data.push(json.value);\n" if data
      str = str + "#{chart}.data.labels.push(json.label);\n" if labels 
      str = str + "#{chart}.update();\n};"
      @push = str
    end
    
    def pop(dataset: 0, chart: @chart, data: true, labels: true)
      str = ""
			str = str + "source.onmessage = function(e) { json = JSON.parse(e.data);"
      str = str + "#{chart}.data.datasets[#{dataset}].data.pop();" if data
      str = str + "#{chart}.data.labels.pop();" if labels
      str = str + "#{chart}.update();};"
      @pop = str
    end
    
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
      str = str + "var #{counter} = 0;"
			str = str + "source.onmessage = function(e) { #{counter} += 1 };"
    end

    def chart(chart_obj = nil)
      return @chart if chart_obj.nil?
      @chart = chart_obj
    end

		def initialize(path, chart)
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
