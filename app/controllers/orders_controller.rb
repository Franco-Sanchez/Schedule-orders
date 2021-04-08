class OrdersController < ApplicationController
  # GET /
  def new
    @client = Client.new
    @order = Order.new
  end

  # POST /orders
  def create
    client = Client.new(name: params[:order][:name], email: params[:order][:email],
                        address: params[:order][:address], phone: params[:order][:phone])
    if client.save
      create_order(client)
    else
      render :new
    end
  end

  private

  def create_order(client)
    @order = Order.new(product_name: params[:order][:product_name])
    @order.client = client
    @order.store = Order.store_found(params[:order][:product_name])
    if @order.save
      redirect_to root_path
    else
      render :new
    end
  end

  def order_params
    params.permit(:price, :status, :product_name)
  end

  def client_parms
    params.permit(:name, :email, :address, :phone)
  end
end
