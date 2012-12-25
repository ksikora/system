class Report < ActiveRecord::Base
  attr_accessible :average, :max, :min, :device_id, :standard_deviation
	belongs_to :device
end
