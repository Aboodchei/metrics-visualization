FactoryBot.define do
  factory :metrics_aggregate do
    aggregate_type { "average" }
    timespan { "day" }
  end
end
