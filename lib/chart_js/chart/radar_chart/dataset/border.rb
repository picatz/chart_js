module ChartJS

  class Border 

    def initialize(container)
      @container = container
    end
    
    def build(&block)
      instance_eval(&block)
      @container 
    end

    def color(value)
      @container['borderColor'] = value
    end
    
    def width(value)
      if value.is_a? Array
        @container['borderWidth'] = value.map(&:to_i) 
      else
        @container['borderWidth'] = value.to_i
      end
    end
    
    def dash(value)
      if value.is_a? Array
        @container['borderDash'] = value.map(&:to_i) 
      else
        raise "Dash must be an array!"
      end
    end
    
    def dash_offset(value)
      @container['borderDashOffset'] = value.to_i
    end

    def cap(value)
      @container['borderCapStyle'] = value
    end
    
    def join(value)
      @container['borderJoinStyle'] = value
    end
    
  end

end
