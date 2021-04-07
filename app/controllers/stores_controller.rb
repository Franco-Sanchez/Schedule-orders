class StoresController < ApplicationController
  before_action :authorized

  # GET /stores/:name
  def show
    @store = Store.find_by(name: params[:name])
  end
end
