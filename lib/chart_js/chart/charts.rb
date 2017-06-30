require "json"
require "securerandom"
require_relative "line_chart/line_chart.rb"
require_relative "bar_chart/bar_chart.rb"
require_relative "radar_chart/radar_chart.rb"

module ChartJS
  module Charts
    def self.debug(&block)
      Chart.new(&block)
    end
    def self.line(&block)
      LineChart.new(&block)
    end
    def self.bar(&block)
      BarChart.new(&block)
    end
    def self.radar(&block)
      RadarChart.new(&block)
    end
  end
end
