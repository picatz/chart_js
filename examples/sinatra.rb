# path setting magic for example directory only
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chart_js"
require "sinatra"

set :bind, "0.0.0.0"

get "/" do
  chart = ChartJS.line do
    data do
      labels ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
      dataset "Cats" do
        color :random
        data [12, 19, 3, 5, 2, 3]
      end 
      dataset "Dogs" do
        color :random
        data [10, 12, 3, 4, 5, 3]
      end 
    end
  end
  chart.to_html
end
