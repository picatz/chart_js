require_relative "dataset/background.rb"
require_relative "dataset/border.rb"
require_relative "dataset/point.rb"
require_relative "dataset/line.rb"

module ChartJS

  class Dataset

    def initialize(label, &block)
      @container = Hash.new
      #fill(false)
      label(label)
      build(&block)
    end
    
    def build(&block)
      instance_eval(&block)
      @container 
    end

    def data(value)
      @container['data'] = value
    end
   
    def label(value)
      @container['label'] = value
    end

    def fill(value = true)
      @container['fill'] = value
    end
    
    def axis_id(value, axis)
      case axis
      when :x
        @container['xAxisID'] = value
      when :y
        @container['yAxisID'] = value
      end
    end
    
    def color(value = :random, type = :both)
      if value == :random
        c = "##{SecureRandom.hex(3)}"
        color c, :border     if type == :both || type == :border 
        color c, :background if type == :both || type == :background
        return 
      end
      case type 
      when :border
        @container['borderColor'] = value
      when :background
        @container['backgroundColor'] = value
      when :both
        color value, :border
        color value, :background
      end
    end
    
    def span_gaps(value = true)
      @container['spanGaps'] = value
    end

    def background(&block)
      @container = Background.new(@container).build(&block)
    end

    def border(&block)
      @container = Border.new(@container).build(&block)
    end
    
    def point(&block)
      @container = Point.new(@container).build(&block)
    end
    
    def line(&block)
      @container = Line.new(@container).build(&block)
    end

    def to_h
      @container
    end

  end

end
