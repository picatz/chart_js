# path setting magic for example directory only
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "chart_js"
require "pry"

ChartJS.build do
  file "example.html"
  type "line"
  data do
    labels ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"]
    dataset "Apples" do
      color :random
      data [12, 19, 3, 5, 2, 3]
    end 
    dataset "Pears" do
      color :random
      data [10, 12, 3, 4, 5, 3]
    end 
  end
end
