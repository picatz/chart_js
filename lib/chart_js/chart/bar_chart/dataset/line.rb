module ChartJS

  class Line 

    def initialize(container)
      @container = container
    end
    
    def build(&block)
      instance_eval(&block)
      @container 
    end
    
  end

end
