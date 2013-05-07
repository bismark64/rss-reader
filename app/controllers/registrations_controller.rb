class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def update
      # required for settings form to submit when password is left blank
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end      

      @user = User.find(current_user.id)
      if @user.update_attributes(params[:user])
        set_flash_message :notice, :updated
        # Sign in the user bypassing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to after_update_path_for(@user)
      else
        render "edit"
      end
  end

  private
  
  def build_resource(*args)
    super
    if session[:omniauth] && params[:user].blank?
      @user = User.new_user_with(session[:omniauth])
    end
  end

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    (user.email != params[:user][:email]) || !params[:user][:password].blank?
  end

end
