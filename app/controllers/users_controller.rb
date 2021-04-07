class UsersController < ApplicationController
  # GET /signup
  def new; end

  # GET /profile
  def show; end

  # POST /signup
  def create
    store = Store.find(params[:store])
    @user = User.new(user_params)
    @user.store = store
    if @user.save
      # redirect_to profile_path
    else
      redirect :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :store)
  end
end
