# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_29_042339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "metrics", force: :cascade do |t|
    t.datetime "timestamp", null: false
    t.string "name", null: false
    t.float "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_metrics_on_name"
    t.index ["timestamp"], name: "index_metrics_on_timestamp"
  end

  create_table "metrics_aggregates", force: :cascade do |t|
    t.string "metric_name"
    t.integer "aggregate_type", default: 0, null: false
    t.integer "timespan", default: 0, null: false
    t.datetime "timestamp", null: false
    t.float "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aggregate_type"], name: "index_metrics_aggregates_on_aggregate_type"
    t.index ["metric_name"], name: "index_metrics_aggregates_on_metric_name"
    t.index ["timespan"], name: "index_metrics_aggregates_on_timespan"
    t.index ["timestamp"], name: "index_metrics_aggregates_on_timestamp"
  end

end
