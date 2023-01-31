module Api::V1
  class MetricsController < ApplicationController
    def index
      render json: formatted_metrics_and_aggregates
    end

    def create
      metric = Metrics::CreateService.call!(timestamp, metric_name, metric_value)
      MetricsAggregates::SyncService.call!(timestamp, metric_name)
      MetricsAggregates::SyncService.call!(timestamp)
      render json: {id: metric.id}
    end

    def destroy
      metric = Metric.find(params[:id])
      Metrics::DestroyService.call!(metric)
      MetricsAggregates::SyncService.call!(metric.timestamp, metric.name)
      MetricsAggregates::SyncService.call!(metric.timestamp)
      render json: {id: metric.id}
    end

    private

    def formatted_metrics_and_aggregates
      {
        metrics: Metric.select(:id, :name, :value, :timestamp),
        metrics_aggregates: MetricsAggregate.select(:metric_name, :value, :timestamp, :timespan, :aggregate_type)
      }
    end

    def timestamp
      params[:timestamp].to_time
    end

    def metric_name
      params[:metric_name]
    end

    def metric_value
      params[:metric_value]
    end

  end
end
