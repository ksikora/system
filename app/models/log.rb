class Log < ActiveRecord::Base
  attr_accessible :content, :device_id, :generation_date
	belongs_to :device
end
