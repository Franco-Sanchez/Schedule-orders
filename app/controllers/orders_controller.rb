class OrdersController < ApplicationController
  # GET /orders/new
  def new
    @client = Client.new
    @order = Order.new
  end

  # POST /orders
  def create
    # order = Order.new
  end
end
