class UsersController < ApplicationController
  # GET /signup
  def new
    @user = User.new
  end

  # POST /signup
  def create
    store = Store.find_by(name: params[:store])
    user = User.new
    user.store = store
  end
end
