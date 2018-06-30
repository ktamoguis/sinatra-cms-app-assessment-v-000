class Region < ActiveRecord::Base
  has_many :agents
  has_many :leads, :through => :agents

  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Region.all.find{|region| region.slug == slug}
  end

end