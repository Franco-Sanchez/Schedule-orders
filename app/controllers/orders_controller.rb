class OrdersController < ApplicationController
  # GET /
  def new
    @client = Client.new
    @order = Order.new
  end

  # POST /orders
  def create
    client = Client.new(client_parms)
    if client.save
      create_order(client)
    else
      render :new
    end
  end

  private

  def create_order(client)
    @order = Order.new(order_params)
    @order.client = client
    @order.store = Order.store_found(params[:product_name])
    if @order.save
      redirect_to root_path
    else
      render :new
    end
  end

  def order_params
    params.require(:order).permit(:price, :status, :product_name)
  end

  def client_parms
    params.require(:client).permit(:name, :email, :address, :phone)
  end
end
