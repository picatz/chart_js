require_relative "dataset.rb"
require_relative "helpers/dates.rb"

module ChartJS

  class Data

    include Helpers::Dates

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

    def to_h(type)
      case type
      when :pie
        @container  
        @container['labels'] = Array.new
        @container['datasets'] = Array.new
        @container['datasets'] << Hash.new
        @datasets.each do |label, data|
          @container['labels'] << label
          data.to_h.each do |key, value|
            if @container['datasets'][0][key].is_a? Array
              @container['datasets'][0][key] << value
            else
              @container['datasets'][0][key] = Array.new
              @container['datasets'][0][key] << value
            end
          end
        end
        @container  
      else
        cont = @container.dup
        cont['datasets'] = []
        @datasets.each do |_, data|
          cont['datasets'] << data.to_h
        end
        cont

      end
    end

  end

end
