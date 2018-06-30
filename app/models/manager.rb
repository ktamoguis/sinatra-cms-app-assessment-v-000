class Manager < ActiveRecord::Base
  has_many :agents
  has_many :leads, thru => :agents

end