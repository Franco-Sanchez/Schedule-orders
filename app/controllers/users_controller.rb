class UsersController < ApplicationController
  # GET /signup
  def new
    @user = User.new
  end

  # GET /profile
  def show; end

  # POST /signup
  def create
    store = Store.find_by(name: params[:store])
    user = User.new
    user.store = store
    if user.save
      # redirect_to profile_path
    else
      redirect :new
    end
  end
end
