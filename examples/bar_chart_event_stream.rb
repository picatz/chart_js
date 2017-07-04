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
        { label: Time.now.strftime("%r"), value: WillowRun::Status.new.getinfo.agrctlrssi }
      end
      sleep 2
    end
  end
end

get "/" do
  chart = ChartJS.bar do
    data do
      labels Array.new
      dataset WillowRun::Status.new.getinfo.ssid do
        color :random
        data Array.new
      end
    end 
    event_stream "/update_source" do
      push
    end
  end
  chart.to_html
end
