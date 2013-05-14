class Channel < ActiveRecord::Base
  require 'feedzirra'

  attr_accessible :name, :url, :user_id

  belongs_to :user
  has_many :articles, :dependent => :destroy

  validates :name, :url, :user_id, :presence => true

  searchable do
    text :name
  end

  def self.can_add_channel?(user)
    allowed = user.profile_type == 'basic' ? 1 : user.profile_type == 'medium' ? 20 : 100
    user.channel_count < allowed ? true : false
  end

  # Add a new channel
  def self.fetch_from_url(feed_url, user_id)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    unless feed.nil? || feed.class == Fixnum
      channel = Channel.create(:name     => feed.title,
                                :url     => feed_url,
                                :user_id => user_id)
      channel.add_entries(feed.entries)
      channel
    end
  end

  # Cron update channels
  def self.cron_update
    Channel.all_urls.each do |channel|
      feed = Feedzirra::Feed.fetch_and_parse(channel.url)
      updated_feed = Feedzirra::Feed.update(feed)
      channel.add_entries(updated_feed.new_entries) if updated_feed.updated?
    end
  end

  #Add articles to a channel
  def add_entries(entries)
    entries.each do |entry|
      description = entry.content || entry.summary
      Article.create!(
        :title        => entry.title,
        :description  => description,
        :link         => entry.url,
        :pubDate      => entry.published,
        :guid         => entry.id,
        :channel_id   => self.id,
        :starred      => false)
    end
  end

  private

  def self.all_urls
    self.find(:all, :select => [:id, :url])
  end

end
