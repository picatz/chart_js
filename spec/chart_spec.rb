require "spec_helper"

RSpec.describe ChartJS::Chart do
  describe '.new' do
    it "can initialize a new base chart" do
      expect(ChartJS::Chart.new).to be_a ChartJS::Chart
    end
  end
  describe '.new { ...dsl... }' do
    it "can initialize and build a chart using the dsl" do
      chart = ChartJS::Chart.new { type "line" }
      expect(chart.type).to eq "line"
    end
  end
  describe '.build { ...dsl... }' do
    it "can build a chart using the dsl" do
      chart = ChartJS::Chart.new
      chart.build { type "line" }
      expect(chart.type).to eq "line"
    end
  end
end
