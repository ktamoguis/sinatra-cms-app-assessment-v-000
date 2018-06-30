class Agent < ActiveRecord::Base
  has_many :leads
  belongs_to :manager

  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Agent.all.find{|agent| agent.slug == slug}
  end

end
