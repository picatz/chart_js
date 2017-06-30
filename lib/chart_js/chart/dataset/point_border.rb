module ChartJS

  class PointBorder 

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
      when :hover
        @container['pointHoverBorderColor'] = value
      when :no_hover
        @container['pointBorderColor'] = value
      when :both
        color value, :hover
        color value, :no_hover
      end
    end
    
  end

end
