module ChartJS

  module EventStreams
    class Push
      def initialize(chart:, dataset:, &block)
        @str = ""
        @chart = chart
        dataset(dataset)
        @str << "source.onmessage = function(e) { \n"
        @str << "json = JSON.parse(e.data);\n"
        base(json: 'data', dataset: dataset, chart: chart)
        @str << "if(json.label){ #{chart}.data.labels.push(json.label); }\n"
        @str << "#{chart}.update();\n"
        build(&block) if block_given?
        @str << "\n};"
      end

      def build(&block)
        instance_eval(&block)
        self
      end

      def dataset(value = nil)
        return @dataset || 0 if value.nil?
        @dataset = value 
      end

      def point(type, chart: @chart, dataset: @dataset)
        case type
        when :hit_radius
          base(json: 'pointHitRadius',        dataset: dataset, chart: chart)
        when :style
          base(json: 'point_style',           dataset: dataset, chart: chart)
        when :border
          color :border,        chart: chart, dataset: dataset
          base(json: 'pointBorder',           dataset: dataset, chart: chart)
          base(json: 'pointBorderWidth',      dataset: dataset, chart: chart)
        when :radius
          base(json: 'pointRadius',           dataset: dataset, chart: chart)
        when :hover_radius
          base(json: 'pointHoverRadius',      dataset: dataset, chart: chart)
        else
          point :hit_radius,    chart: chart, dataset: dataset
          point :style,         chart: chart, dataset: dataset
          point :border,        chart: chart, dataset: dataset
          point :hover_radius,  chart: chart, dataset: dataset
        end
      end

      def color(type, chart: @chart, dataset: @dataset)
        case type
        when :background
          base(json: 'backgroundColor',           dataset: dataset, chart: chart)
        when :border
          base(json: 'borderColor',               dataset: dataset, chart: chart)
        when :point
          base(json: 'pointBackgroundColor',      dataset: dataset, chart: chart)
          base(json: 'pointBorderColor',          dataset: dataset, chart: chart)
          base(json: 'pointHoverBackgroundColor', dataset: dataset, chart: chart)
          base(json: 'pointHoverBorderColor',     dataset: dataset, chart: chart)
          base(json: 'pointHoverBorderColor',     dataset: dataset, chart: chart)
          base(json: 'pointHoverBorderColor',     dataset: dataset, chart: chart)
        else
          color :background,  chart: chart, dataset: dataset
          color :border,      chart: chart, dataset: dataset
          color :point,       chart: chart, dataset: dataset
        end
      end

      def base(json:, chart:, dataset:, raw: false)
        @str << "if(json.#{json}){ #{chart}.data.datasets[#{dataset}].#{json}.push(json.#{json}); }\n"
      end

      def to_s
        @str
      end
    end
  end

end
