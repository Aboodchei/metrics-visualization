require 'rails_helper'

RSpec.describe Api::V1::MetricsController, type: :request do
  let!(:time) { Time.parse("2023-01-30 06:45:12 UTC") }
  let!(:metric) { create(:metric, name: "test_1", timestamp: time, value: 18) }
  let(:time_strf) { time.strftime('%Y-%m-%d %H:%M:%S') }
  let(:current_day) { time.beginning_of_day.strftime('%Y-%m-%d %H:%M:%S') }
  let(:current_hour) { time.beginning_of_hour.strftime('%Y-%m-%d %H:%M:%S') }
  let(:current_minute) { time.beginning_of_minute.strftime('%Y-%m-%d %H:%M:%S') }

  describe "GET /api/v1/metrics" do
    before do
      seed_metrics_aggregates
    end

    it "returns metrics and metric aggregates" do
      get api_v1_metrics_path
      expect(JSON.parse(response.body).deep_symbolize_keys).to eq({
        metrics: [{
          id: metric.id, name: metric.name, timestamp: time_strf, value: metric.value
        }],
        metrics_aggregates: [
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_day, timespan: "day", value: 18.0},
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_hour, timespan: "hour", value: 18.0},
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_minute, timespan: "minute", value: 18.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_day, timespan: "day", value: 18.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_hour, timespan: "hour", value: 18.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_minute, timespan: "minute", value: 18.0},
        ]
      })
    end
  end

  describe "POST /api/v1/metrics" do
    context "successfully creates metrics and syncs metric aggregates" do
      let(:expected_metrics) {
        [
          {id: metric.id, name: "test_1", timestamp: time_strf, value: metric.value},
          {id: @metric_1_id, name: "test_1", timestamp: time_strf, value: 19.0},
          {id: @metric_2_id, name: "test_2", timestamp: time_strf, value: 23.0},
        ]
      }
      let(:expected_metrics_aggregates) {
        [
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_day, timespan: "day", value: 18.5},
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_hour, timespan: "hour", value: 18.5},
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_minute, timespan: "minute", value: 18.5},
          {metric_name: "test_2", aggregate_type: "average", timestamp: current_day, timespan: "day", value: 23.0},
          {metric_name: "test_2", aggregate_type: "average", timestamp: current_hour, timespan: "hour", value: 23.0},
          {metric_name: "test_2", aggregate_type: "average", timestamp: current_minute, timespan: "minute", value: 23.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_day, timespan: "day", value: 20.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_hour, timespan: "hour", value: 20.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_minute, timespan: "minute", value: 20.0},
        ]
      }
      it "with existing metric aggregates" do
        seed_metrics_aggregates
        assert_metrics_creation_functionality!
      end

      it "with no pre-existing metric aggregates" do
        assert_metrics_creation_functionality!
      end
    end
  end

  describe "DELETE /api/v1/metrics" do
    before do
      seed_metrics_aggregates
    end

    it "successfully deletes metrics and syncs metrics aggregates" do
      delete api_v1_metric_path(id: metric.id)
      expect(response).to be_successful
      get api_v1_metrics_path
      expect(JSON.parse(response.body).deep_symbolize_keys).to eq({
        metrics: [],
        metrics_aggregates: [
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_day, timespan: "day", value: 0.0},
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_hour, timespan: "hour", value: 0.0},
          {metric_name: "test_1", aggregate_type: "average", timestamp: current_minute, timespan: "minute", value: 0.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_day, timespan: "day", value: 0.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_hour, timespan: "hour", value: 0.0},
          {metric_name: nil, aggregate_type: "average", timestamp: current_minute, timespan: "minute", value: 0.0},
        ]
      })
    end
  end

  def assert_metrics_creation_functionality!
    post api_v1_metrics_path, params: {
      timestamp: time.to_s,
      metric_name: "test_1",
      metric_value: "19.0"
    }
    @metric_1_id = JSON.parse(response.body)["id"]

    post api_v1_metrics_path, params: {
      timestamp: time.to_s,
      metric_name: "test_2",
      metric_value: "23.0"
    }
    @metric_2_id = JSON.parse(response.body)["id"]

    get api_v1_metrics_path
    parsed = JSON.parse(response.body).deep_symbolize_keys
    actual_metrics = parsed[:metrics]
    actual_metrics_aggregates = parsed[:metrics_aggregates]
    expect(actual_metrics).to match_array(expected_metrics)
    expect(actual_metrics_aggregates).to match_array(expected_metrics_aggregates)
  end

  def seed_metrics_aggregates
    create(:metrics_aggregate, metric_name: metric.name, timestamp: current_day, value: 18, timespan: "day")
    create(:metrics_aggregate, metric_name: metric.name, timestamp: current_hour, value: 18, timespan: "hour")
    create(:metrics_aggregate, metric_name: metric.name, timestamp: current_minute, value: 18, timespan: "minute")
    create(:metrics_aggregate, timestamp: current_day, value: 18, timespan: "day")
    create(:metrics_aggregate, timestamp: current_hour, value: 18, timespan: "hour")
    create(:metrics_aggregate, timestamp: current_minute, value: 18, timespan: "minute")    
  end
end
