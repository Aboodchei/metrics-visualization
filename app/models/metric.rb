# == Schema Information
#
# Table name: metrics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  timestamp  :datetime         not null
#  value      :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_metrics_on_name       (name)
#  index_metrics_on_timestamp  (timestamp)
#
class Metric < ApplicationRecord
  def as_json(_options)
    {
      id: id,
      name: name,
      value: value,
      timestamp: timestamp.strftime('%Y-%m-%d %H:%M:%S'),
    }
  end
end
