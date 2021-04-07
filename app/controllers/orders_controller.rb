class OrdersController < ApplicationController
  # GET /orders/new
  def new
    @client = Client.new
    @order = Order.new
  end

  # POST /orders
  def create
    # client = Client.new
    # order = Order.new
  end
end
