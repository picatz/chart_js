require_relative "dataset.rb"

module ChartJS

  class Data

    def initialize
      @container = Hash.new
      @datasets  = Hash.new
    end
    
    def build(&block)
      instance_eval(&block)
      self
    end

    def labels(labels = nil)
      raise "Not an array!" unless labels.is_a? Array
      @container['labels'] = labels
    end

    def dataset(label, &block)
      @datasets[label] = Dataset.new(label, &block)
    end

    def to_h
      cont = @container.dup
      cont['datasets'] = []
      @datasets.each do |_, data|
        cont['datasets'] << data.to_h
      end
      cont
    end

  end

end
