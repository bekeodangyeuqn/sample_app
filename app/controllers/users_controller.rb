class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def show; end

  def index
    @pagy, @users = pagy(User.by_recently_created)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t("welcome")
      redirect_back_or user
    else
      flash.now[:danger] = t("log_in_flash")
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t("profile_updated")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("user_deleted")
      redirect_to users_url
    else
      flash.now[:danger] = t("error_delete")
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                                        :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t("please_log_in")
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash.now[:danger] = t("notfound")
    redirect_to root_path
  end
end
