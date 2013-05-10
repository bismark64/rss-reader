class LastFeed < ActionMailer::Base
  default from: "last_feed@example.com"

  def to_user(users)
    users.each do |user|
      @user = user
      @last_feed = @user.articles[0..4]
      mail(:to => @user.email, :subject => "Last Feed from Rss Reader")
    end
  end
end
