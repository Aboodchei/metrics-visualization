# == Schema Information
#
# Table name: metrics_aggregates
#
#  id             :bigint           not null, primary key
#  aggregate_type :integer          default("average"), not null
#  metric_name    :string
#  timespan       :integer          default("day"), not null
#  timestamp      :datetime         not null
#  value          :float            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_metrics_aggregates_on_aggregate_type  (aggregate_type)
#  index_metrics_aggregates_on_metric_name     (metric_name)
#  index_metrics_aggregates_on_timespan        (timespan)
#  index_metrics_aggregates_on_timestamp       (timestamp)
#
class MetricsAggregate < ApplicationRecord
  enum aggregate_type: { average: 0 }, _prefix: true # avoid clashes with AR default methods
  enum timespan: { day: 0, hour: 1, minute: 2 }

  def as_json(_options)
    {
      aggregate_type: aggregate_type,
      metric_name: metric_name,
      value: value,
      timespan: timespan,
      timestamp: timestamp.strftime('%Y-%m-%d %H:%M:%S'),
    }
  end
end
