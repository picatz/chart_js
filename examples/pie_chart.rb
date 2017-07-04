# path setting magic for example directory only
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chart_js"

ChartJS.pie do
  file "example.html"
  data do
    dataset "a" do
      color :random
      data 1
    end
    dataset "b" do
      color :random
      data 2
    end
    dataset "c" do
      color :random
      data 3
    end
  end
end
