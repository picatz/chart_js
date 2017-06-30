module ChartJS

  class Background 

    def initialize(container)
      @container = container
    end
    
    def build(&block)
      instance_eval(&block)
      @container 
    end

    def color(value)
      @container['backgroundColor'] = value
    end

  end

end
