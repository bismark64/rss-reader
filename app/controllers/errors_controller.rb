class ErrorsController < ApplicationController
  def not_found
    flash.keep[:error] = "The page that you are looking for doesn't exist"
    # render :status => 404, :formats => [:html]
    redirect_to root_url
  end

  def server_error
    flash.keep[:error] = "There was an internal error"
    # render :status => 500, :formats => [:html]
    redirect_to root_url
  end
end