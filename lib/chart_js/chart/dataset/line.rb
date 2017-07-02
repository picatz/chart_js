module ChartJS

  class Line 

    def initialize(container)
      @container = container
    end
    
    def build(&block)
      instance_eval(&block)
      @container 
    end

    def stepped(value = true)
      @container['steppedLine'] = case value
      when true # Step-before Interpolation -> eq "before"
        true
      when false # No Step Interpolation
        false
      when :before || "before"
        "before"
      when :after || "after"
        "after"
      else
        raise "Oops."
      end
    end
    
    def tension(value = 1)
      if value.is_a? Integer
        @container['lineTension'] = value
      elsif value == "flase" ||  value == :false
        @container['lineTension'] = 0
      else
        raise "Oops"
      end
    end

  end

end
