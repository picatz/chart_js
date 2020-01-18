# coding: utf-8
# This file is part of ChartJS
# See https://github.com/picatz/chart_js for more information.
# Copyright (C) 2017 Kent 'picat' Gruber
# This program is published under MIT license.

require "chart_js/version"
require "chart_js/chart/chart"

# Chart JS is a simple yet flexible JavaScript charting library. This
# gem is a Ruby Domain Specific Language which allows you to easily
# build charts without touching a single line of JavaScript or HTML.
# @author Kent 'picat' Gruber
module ChartJS
  # NOTE: I did not write every word of this inline documentation and credit
  # much of it to to people over at http://www.chartjs.org/

  # Build a chart, do some stuff!
  def self.build(&block)
    Chart.new(&block)
  end

  # A line chart is a way of plotting data points on a line. Often,
  # it is used to show trend data, or the comparison of two data sets.
  def self.line(&block)
    chart = Chart.new
    chart.type('line')
    chart.build(&block)
  end

  # A radar chart is a way of showing multiple data points and
  # the variation between them. They are often useful for
  # comparing the points of two or more different data sets.
  def self.radar(&block)
    chart = Chart.new
    chart.type('radar')
    chart.build(&block)
  end

  # Pie charts are probably one of the most commonly used charts.
  # They are divided into segments, the arc of each segment
  # shows the proportional value of each piece of data. They are
  # excellent at showing the relational proportions between data.
  def self.pie(&block)
    chart = Chart.new
    chart.type('pie')
    chart.build(&block)
  end

  # Doughnut charts are probably one of the most commonly used charts.
  # They are divided into segments, the arc of each segment
  # shows the proportional value of each piece of data. They are
  # excellent at showing the relational proportions between data but
  # with a big'O hole in the middle.
  def self.doughnut(&block)
    chart = Chart.new
    chart.type('doughnut')
    chart.build(&block)
  end

  # A bar chart provides a way of showing data values represented
  # as vertical bars. It is sometimes used to show trend data,
  # and the comparison of multiple data sets side by side.
  def self.bar(type = :vertical, &block)
    chart = Chart.new
    case type
    when :vertical
      chart.type('bar')
    when :horizontal
      chart.type('horizontalBar')
    end
    chart.build(&block)
  end

  # Need to send some server-side event data? You found your method. Optionally, it'll
  # even call the "to_json" on the object your sending ( if it accepts
  # that method call ); otherwise you should really only send
  # JSON that is already formatted. Otherwise it'll just send the plaintext.
  #
  # Live life the way you want to.
  def self.data(json: false, &block)
    if json
      "data: #{block.call} \r\n\n"
    else
      "data: #{block.call.to_json} \r\n\n"
    end
  end
end
