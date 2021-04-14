class OrdersController < ApplicationController
  # GET /
  def new
    @client = Client.new
    @order = Order.new
  end

  # POST /
  def create
    @client = Client.new(client_params)
    if @client.save
      store = Order.store_found(params[:product_name])
      create_order(store)
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

  def client_params
    params.permit(:name, :email, :address, :phone)
  end

  def create_order(store)
    @order = Order.new(product_name: params[:product_name])
    @order.client = @client
    if store.is_a?(Array)
      @order.save
      render :new
    else
      @order.store = store
      @order.save
      redirect_to root_path
    end
  end

  def update_price
    params[:order][:price] && @order.update(price: params[:order][:price])
  end
end
