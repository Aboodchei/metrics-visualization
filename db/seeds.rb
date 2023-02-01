puts "Seeding.."

current_time = Time.zone.now
5.times do |x|
  name = "example_#{x}"
  puts "Seeding #{name}.."
  1000.times do |n|
    value = rand(-50.0..50.0).round(2)
    time_with_offset = current_time + rand(-300..300).seconds
    Metrics::CreateService.call!(time_with_offset, name, value)
    MetricsAggregates::SyncService.call!(time_with_offset, name)
    MetricsAggregates::SyncService.call!(time_with_offset)
  end
end
