class Article < ActiveRecord::Base
  attr_accessible :channel_id, :description, :guid, :link, :pubDate, :title, :starred

  validates :title, :link, :description, :guid, :channel_id, :pubDate, :presence => true
  validates :guid, :uniqueness => true

  has_many :comments, :dependent => :destroy

  scope :starred, lambda { || where(:starred => true)}

  def star_article
    self.toggle(:starred).save
  end
end
