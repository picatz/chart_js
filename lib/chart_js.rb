require "chart_js/version"
require "chart_js/chart/chart"
require "chart_js/chart/charts"

module ChartJS
  def self.build(&block)
    Chart.new(&block)
  end
  
  def self.line(&block)
    Charts.line(&block)
  end

  def self.radar(&block)
    Charts.radar(&block)
  end
  
  def self.bar(&block)
    Charts.bar(&block)
  end
end
