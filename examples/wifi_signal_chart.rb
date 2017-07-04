# path setting magic for example directory only
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chart_js"
require "willow_run"
require "sinatra"

get "/update_source", provides: 'text/event-stream' do 
  stream(:keep_open) do |out|
    loop do
      out << ChartJS.data do
        { label: Time.now.strftime("%r"), data: WillowRun::Status.new.getinfo.agrctlrssi }
      end
      sleep 2
    end
  end
end

get "/" do
  chart = ChartJS.line do
    data do
      labels Array.new
      dataset WillowRun::Status.new.getinfo.ssid do
        color :random
        data Array.new
        point do
          radius 0
          hit_radius 2
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
