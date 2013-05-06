class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  private
  
  def build_resource(*args)
    super
    if session[:omniauth] && params[:user].blank?
      @user = User.new_user_with(session[:omniauth])
    end
  end

end
