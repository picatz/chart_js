# path setting magic for example directory only
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chart_js"
require "willow_run"
require "sinatra"

set :bind, '0.0.0.0'
set :port, 3141

get "/update_source", provides: 'text/event-stream' do 
  stream(:keep_open) do |out|
    loop do
      out << ChartJS.data do
        { label: Time.now.strftime("%r"), 
          value: WillowRun::Status.new.getinfo.agrctlrssi 
          color: "##{SecureRandom.hex(6)}"
        }
      end
      sleep 5
    end
  end
end

get "/" do
  chart = ChartJS.build do
    type "line"
    data do
      labels Array.new
      dataset WillowRun::Status.new.getinfo.ssid do
        color Array.new
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
