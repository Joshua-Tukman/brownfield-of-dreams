class UsersController < ApplicationController
  def show
    @bookmarked_collection = UserVideo.bookmarked_videos(current_user)
    return unless current_user.token

    @repos = SearchResults.new.repos(current_user.token)
    @followers = SearchResults.new.followers(current_user.token)
    @followed_users = SearchResults.new.following(current_user.token)
  end

  def new
    @user = User.new
  end

  def activate
    user = User.find(params[:user_id])
    user.update(activation_status: 1)
    flash[:notice] = 'Your account has now been activated'
    redirect_to dashboard_path
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      ActivationMailer.activate(user).deliver_now
      flash[:notice] = 'Check your email to activate your account!'
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
