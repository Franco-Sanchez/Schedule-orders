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

  # PATCH /orders/:id
  def update
    @order = Order.find(params[:id])
    update_order
    @order.update(status: params[:order][:status])
    redirect_to store_path(name: current_user.store.name)
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

  def update_order
    if params[:order][:status] == 'approved' && params[:order][:price]
      @order.update(price: params[:order][:price])
    elsif params[:order][:status] == 'discarded'
      call_create
    end
  end

  def call_create
    @order_new = Order.create(price: @order.price, product_name: @order.product_name,
                              client: @order.client,
                              store: Order.store_found(@order.product_name, @order.store.id))
  end
end
