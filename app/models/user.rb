class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  devise :omniauthable, :omniauth_providers => [:twitter, :google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name, :login, :auth_token, :auth_secret, :provider, :uid

  validates :first_name, :last_name, :login, :email, :password, :presence => true
  validates :first_name, :last_name, :login, :length => { :maximum => 50 }
  validates :email, :confirmation => true
  validates :email, :uniqueness => true

   ##### Twitter #####
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.find_by_provider_and_uid(auth.provider, auth.uid)
  end

  def self.new_user_with(auth)
    if auth.provider == 'twitter'
      user = User.new(:login => auth.info.nickname,
                     :first_name => User.get_first_name(auth.info.name),
                     :last_name => User.get_last_name(auth.info.name),
                     :auth_token => auth.credentials.token,
                     :auth_secret => auth.credentials.secret,
                     :provider => auth.provider,
                     :uid => auth.uid)
    else
      user = User.new(:login => auth.info.name.split(" ").collect{ |name_part| name_part.capitalize}.join(" "), 
                         :email => auth.info.email,
                         :first_name => auth.info.first_name,
                         :last_name => auth.info.last_name,
                         :auth_token => auth.credentials.token,
                         :provider => auth.provider,
                         :uid => auth.uid)
    end
    user
  end

  ##### Google #####
  def self.find_for_google_oauth(auth, signed_in_resource=nil)
    user = User.find_by_provider_and_uid(auth.provider, auth.uid)
  end

  private

  def self.get_first_name(name)
    name_array = name.split(" ")
    name_array.length == 2 ? name_array.first : name_array.reverse.drop(1).reverse.join(" ")
  end  

  def self.get_last_name(name)
    name.split(" ").last
  end
end
