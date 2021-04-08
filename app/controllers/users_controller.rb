class UsersController < ApplicationController
  # GET /signup
  def new
    @user = User.new
  end

  # GET /profile
  def show; end

  # POST /signup
  def create
    store = Store.find_by(name: params[:store_name])
    @user = User.new(user_params)
    @user.store = store
    if @user.save
      session[:user_id] = @user.id
      redirect_to store_path(name: store.name)
    else
      render :new
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :store_name)
  end
end
