class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)

    if @user.blank?
      session[:omniauth] = request.env["omniauth.auth"].except("extra")
      flash[:info] = t('messages.flash.omniauth')
      redirect_to new_user_registration_url
    else
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    end
  end

  def google_oauth2
    @user = User.find_for_google_oauth(request.env["omniauth.auth"], current_user)

    if @user.blank?
      session[:omniauth] = request.env["omniauth.auth"].except("extra")
      flash[:info] = t('messages.flash.omniauth')
      redirect_to new_user_registration_url
    else
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    end
  end
end