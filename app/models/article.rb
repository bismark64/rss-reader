class Article < ActiveRecord::Base
  attr_accessible :channel_id, :description, :guid, :link, :pubDate, :title

  validates :title, :link, :description, :guid, :channel_id, :pubDate, :presence => true
  validates :guid, :uniqueness => true
end
