class CreateMetricsAggregates < ActiveRecord::Migration[6.1]
  def change
    create_table :metrics_aggregates do |t|
      t.string :metric_name, index: true
      t.integer :aggregate_type, null: false, index: true, default: 0
      t.integer :timespan, null: false, index: true, default: 0
      t.datetime :timestamp, null: false, index: true
      t.float :value, null: false

      t.timestamps
    end
  end
end
