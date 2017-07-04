# path setting magic for example directory only
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chart_js"

ChartJS.radar do
  file "example.html"
  data do
    labels ["a", "b", "c"]
    dataset "Example" do
      color :random
      data [1, 2, 3]
    end 
  end
end
