class Agent < ActiveRecord::Base
  has_many :leads
  belongs_to :manager

end
