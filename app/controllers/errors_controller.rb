class ErrorsController < ApplicationController
  def not_found
    flash[:error] = "Not Found"
    render :status => 404, :formats => [:html]
  end

  def server_error
    flash[:error] = "Murio Server"
    render :status => 500, :formats => [:html]
  end
end