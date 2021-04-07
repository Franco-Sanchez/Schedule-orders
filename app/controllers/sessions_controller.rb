class SessionsController < ApplicationController
  # GET /login
  def new; end

  # POST /login
  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      store = @user.store
      redirect_to store
    else
      redirect_to login_path
    end
  end

  # DELETE /logout
  def destroy
    session[user_id] = nil
    redirect_to login_path
  end
end
