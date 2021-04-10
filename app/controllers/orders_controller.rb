class OrdersController < ApplicationController
  # GET /
  def new
    @client = Client.new
    @order = Order.new
  end

  # POST /orders
  def create
    @client = Client.new(name: params[:order][:name], email: params[:order][:email],
                         address: params[:order][:address], phone: params[:order][:phone])
    if @client.save
      create_order
    else
      render :new
    end
  end

  # PATCH /orders/:id
  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:order][:status])
    update_price
    redirect_to store_path(name: current_user.store.name)
  end

  private

  def create_order
    @order = Order.new(product_name: params[:order][:product_name])
    @order.client = @client
    @order.store = Order.store_found(params[:order][:product_name])
    if @order.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update_price
    params[:order][:price] && @order.update(price: params[:order][:price])
  end
end
