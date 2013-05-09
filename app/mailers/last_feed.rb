class LastFeed < ActionMailer::Base
  default from: "from@example.com"

  def to_user(users)
    #mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
