class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
        log_in user
        redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = t(".log_in_flash")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
