class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
    @order=Order.new
  end

  #this is for creating the order.
  def create
    @order = Order.new(order_params)
    if @orders.save
      # Handle successful order creation, e.g., redirecting to a success page
      flash[:success] = "Dear #{current_user.username}, Your order has beed received sucessfully. Kindly wait as we process it."
      #render for payment
    else
      # Handle failed order creation, e.g., rendering the form with error messages
      flash[:danger] = "Dear #{current_user.username}, your Order has NOT been received."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:sender_name, :sender_phone, :sender_email, :source_location, :recipient_name, :recipient_phone, :recipient_email, :destination_location, :services, :description)
  end

end
