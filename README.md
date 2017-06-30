# Chart JS

[Chart JS](http://www.chartjs.org/) is a simple yet flexible JavaScript charting library. This [gem](https://rubygems.org/) is a Ruby [Domain Specific Language](https://en.wikipedia.org/wiki/Domain-specific_language) which allows you to easily build charts without touching a single line of JavaScript or HTML.

## Installation

This gem is still in development. Install with `--pre`.

    $ gem install chart_js --pre

## Usage

A simple example to generate a static html file.

```ruby
require "chart_js"

ChartJS.line do
  file "example.html"
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
```

## Web Framework Integration

`chart_js` plays well with others.

```ruby
require "chart_js"
require "sinatra"

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
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

