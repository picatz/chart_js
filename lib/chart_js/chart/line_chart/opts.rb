require_relative "dataset.rb"

module ChartJS

  class Options 

    def initialize
      @container = Hash.new
    end
    
    def build(&block)
      instance_eval(&block)
      @container
    end

  end

end
