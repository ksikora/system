class Device < ActiveRecord::Base
  attr_accessible :dtype, :name, :sends_logs
end
