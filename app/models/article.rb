class Article < ActiveRecord::Base
  attr_accessible :channel_id, :description, :guid, :link, :pubDate, :title, :starred

  validates :title, :link, :description, :guid, :channel_id, :pubDate, :presence => true
  validates :guid, :uniqueness => true

  has_many :comments, :dependent => :destroy

  searchable do
    text :title, :boost => 2
    text :description
    integer :channel_id
  end

  def star_article
    self.toggle(:starred).save
  end
end
