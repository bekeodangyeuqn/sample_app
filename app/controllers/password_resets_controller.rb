class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(update edit)

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t(".info_flash")
      redirect_to root_url
    else
      flash.now[:danger] = t(".danger_flash")
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      user.errors.add(:password, t(".passEmpty"))
      render :edit
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = t(".updateSuccess")
      redirect_to @user
    else
      redirect_to :edit
    end
  end

  def edit; end

  private

  def get_user
    @user = User.find_by(email: params[:email])
    return if @user

    flash.now[:danger] = t("notfound")
    redirect_to root_path
  end


  def valid_user
    return if @user && @user.activated? && @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return if !(@user.password_reset_expired?)

    flash[:danger] = t(".expired")
    redirect_to new_password_reset_url
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
