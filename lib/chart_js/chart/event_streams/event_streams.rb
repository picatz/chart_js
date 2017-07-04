require_relative 'push'

module ChartJS

  module EventStreams
    def self.push(chart:, dataset:, &block)
      Push.new(chart: chart, dataset: dataset, &block)
    end
  end

end
