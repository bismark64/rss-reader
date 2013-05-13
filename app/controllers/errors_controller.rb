class ErrorsController < ApplicationController
  def not_found
    flash.keep[:error] = "The page that you are looking for doesn't exist"
    redirect_to root_url
    
    # Uncomment the line below (and comment the above one) to show a page instead redirect
    # render :status => 404, :formats => [:html]
  end

  def server_error
    flash.keep[:error] = "There was an internal error"
    redirect_to root_url

    # Uncomment the line below (and comment the above one) to show a page instead redirect
    # render :status => 500, :formats => [:html]
  end
end