module ChartJS

  class Opts 

    def initialize
      @container = Hash.new
    end

    def build(&block)
      instance_eval(&block)
      @container
    end

    def cutout(value = nil)
      return @container['cutoutPercentage'] if value.nil?
      @container['cutoutPercentage'] = value
    end

    def to_h
      @container
    end

  end

end
