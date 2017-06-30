module ChartJS

  class PointHover 

    def initialize(container)
      @container = container
    end
    
    def build(&block)
      instance_eval(&block)
      @container 
    end

    def radius(value)
      if value.is_a? Array
        @container['pointHoverRadius'] = value.map(&:to_i) 
      else
        @container['pointHoverRadius'] = value.to_i
      end
    end
    
    def width(value)
      if value.is_a? Array
        @container['pointHoverBorderWidth'] = value.map(&:to_i) 
      else
        @container['pointHoverBorderWidth'] = value.to_i
      end
    end

    def color(value, type = :both)
      case type 
      when :border
        @container['pointHoverBorderColor'] = value
      when :background
        @container['pointHoverBackgroundColor'] = value
      when :both
        color value, :borer
        color value, :background
      end
    end
    
  end

end
