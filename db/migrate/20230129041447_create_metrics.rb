class CreateMetrics < ActiveRecord::Migration[6.1]
  def change
    create_table :metrics do |t|
      t.datetime :timestamp, null: false, index: true
      t.string :name, null: false, index: true
      t.float :value, null: false

      t.timestamps
    end
  end
end
