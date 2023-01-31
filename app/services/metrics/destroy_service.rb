module Metrics
  class DestroyService < ApplicationService
    def initialize(metric)
      @metric = metric
    end

    def call!
      @metric.destroy!
    end
  end
end
