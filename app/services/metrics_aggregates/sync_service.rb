module MetricsAggregates
  class SyncService < ApplicationService
    def initialize(timestamp, metric_name = nil)
      @timestamp = timestamp
      @metric_name = metric_name
    end

    def call!
      MetricsAggregate.aggregate_types.keys.each do |aggregate_type|
        timespans_and_ranges.each do |timespan, range|
          metric_aggregate = find_or_create_metric_aggregate(aggregate_type, timespan, range)
          value = query_metric_aggregate_value(aggregate_type, range)
          metric_aggregate.update(value: value)
        end
      end
    end

    private

    def timespans_and_ranges
      {
        day: (@timestamp.beginning_of_day..@timestamp.end_of_day),
        hour: (@timestamp.beginning_of_hour..@timestamp.end_of_hour),
        minute: (@timestamp.beginning_of_minute..@timestamp.end_of_minute),
      }
    end

    def find_or_create_metric_aggregate(aggregate_type, timespan, range)
      MetricsAggregate.find_or_initialize_by(
        metric_name: @metric_name,
        aggregate_type: aggregate_type,
        timespan: timespan,
        timestamp: range.first,
      )
    end

    def query_metric_aggregate_value(aggregate_type, range)
      base_query = Metric.where(timestamp: range)
      if @metric_name.present?
        base_query = base_query.where(name: @metric_name)
      end

      case aggregate_type
      when 'average'
        base_query.average(:value).to_f
      end
    end
  end
end
