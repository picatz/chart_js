require_relative 'point_hover.rb'
require_relative 'point_border.rb'

module ChartJS

  class Point 

    def initialize(container)
      @container = container
    end
    
    def build(&block)
      instance_eval(&block)
      @container 
    end

    def hover(&block)
      @container = PointHover.new(@container).build(&block) 
    end
    
    def border(&block)
      @container = PointBorder.new(@container).build(&block) 
    end
    
    def radius(value)
      if value.is_a? Array
        @container['pointRadius'] = value.map(&:to_i) 
      else
        @container['pointRadius'] = value.to_i
      end
    end
    
    def hit_radius(value)
      if value.is_a? Array
        @container['pointHitRadius'] = value.map(&:to_i) 
      else
        @container['pointHitRadius'] = value.to_i
      end
    end

    def color(value, type = :both)
      case type 
      when :border
        @container['pointBorderColor'] = value
      when :background
        @container['pointBackgroundColor'] = value
      when :both
        color value, :borer
        color value, :background
      end
    end
    
  end

end
