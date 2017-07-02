# path setting magic for example directory only
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chart_js"
require "vifi"
require 'pry'

class Vifi
  get "/chart" do
    chart = ChartJS.build do
      type "line"
      data do
        labels Array.new
        dataset WillowRun::Status.new.getinfo.ssid do
          color :random
          data Array.new
          point do
            radius 0
            hit_radius 3
          end
          line do
            tension :false
          end
        end
      end 
      event_stream "/update_source" do
        push
      end
    end
    chart.to_html
  end
end

Vifi.run!
