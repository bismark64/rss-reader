class Channel < ActiveRecord::Base
  require 'feedzirra'

  attr_accessible :name, :url, :user_id

  belongs_to :user
  has_many :articles, :dependent => :destroy

  validates :name, :url, :user_id, :presence => true

  def self.fetch_from_url(feed_url, user_id)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    unless feed.nil?
      channel = Channel.create(:name     => feed.title,
                                :url     => feed_url,
                                :user_id => user_id)
      channel.add_entries(feed.entries)
      channel
    end
  end

  def add_entries(entries)
    entries.each do |entry|
      description = entry.content || entry.summary
      Article.create!(
        :title        => entry.title,
        :description  => description,
        :link         => entry.url,
        :pubDate      => entry.published,
        :guid         => entry.id,
        :channel_id   => self.id)
    end
  end

  def self.cron_update
    all_feed = Feedzirra::Feed.fetch_and_parse(Channel.all_urls)
    feed = Feedzirra::Feed.update(all_feed.values)
    add_entries(feed.new_entries) if feed.updated?
  end

  def self.all_urls
    self.find(:all, :select => [:id, :url])
  end
end
