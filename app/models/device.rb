class Device < ActiveRecord::Base
  attr_accessible :dtype, :name, :sends_logs
	has_many :logs
end
