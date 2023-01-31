module Metrics
  class CreateService < ApplicationService
    def initialize(timestamp, name, value)
      @timestamp = timestamp
      @name = name
      @value = value
    end

    def call!
      Metric.create!(timestamp: @timestamp, name: @name, value: @value)
    end
  end
end
