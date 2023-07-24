class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:payment]

  def new
    @order=current_user.orders.new
  end

  #this is for creating the order.
  def create
    @order = current_user.orders.new(order_params)
    @order.status = :ready_for_dispatch # Set the desired status value
    if @order.save
      # Handle successful order creation, e.g., redirecting to a success page
      redirect_to @order
    else
      # Handle failed order creation, e.g., rendering the form with error messages
      flash[:danger] = "Dear #{current_user.username}, your Order has NOT been received."
      redirect_to new_order_path
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
    redirect_to order_payment_path(@order)
  rescue ActiveRecord::RecordNotFound
    # Handle the case when the order doesn't exist or doesn't belong to the current user
    flash[:danger] = "Dear, #{current_user.username}, you are not authorized to access this Page."
    redirect_to order_history_path
  end

  def order_history
    @orders = current_user.orders.where.not(status: 'Cancelled')
  end

  def cancel
    @order = current_user.orders.find(params[:id])
    @order.update(status: 'Cancelled')
    flash[:success] = "The Order has been Successfully cancelled."
    redirect_to order_path(@order)
  end

  def cancelled_orders
    @cancelled_orders = current_user.orders.where(status: 'Cancelled')
  end

  def payment
    @order = current_user.orders.find(params[:id])
    @credit_card = CreditCard.new # Instantiate a new CreditCard object
  rescue ActiveRecord::RecordNotFound
    # Handle the case when the order doesn't exist or doesn't belong to the current user
    flash[:danger] = "Dear, #{current_user.username}, you are NOT authorized to access another user's Page."
    redirect_to new_order_path
  end

  def process_payment
    @order = current_user.orders.find(params[:id])
    if params[:order][:payment_method] == 'credit_card'
      @credit_card = CreditCard.new(credit_card_params)
      if credit_card_params.present? && @credit_card.valid?
        # Process credit card payment
        flash[:success] = "Payment successful. Thank you!"
        redirect_to order_history_path
      else
        flash[:danger] ="Payment Not sucessful."
        @credit_card ||= CreditCard.new # Instantiate a new CreditCard object if @credit_card is nil
        @credit_card.errors.add(:base, "Credit card details cannot be empty.") if credit_card_params.empty?
        render 'payment'
      end
    elsif params[:order][:payment_method] == 'mpesa'
      # Process M-PESA payment
      flash[:success] = "Payment successful. Thank you!"
      redirect_to order_payment_path(@order)
    else
      flash[:danger] = "Invalid payment method selected."
      redirect_to order_payment_path(@order)
    end
  end

  private

  def order_params
    params.require(:order).permit(:sender_name, :sender_phone, :sender_email, :source_location, :recipient_name, :recipient_phone, :recipient_email, :destination_location, :services, :description)
  end

  def credit_card_params
    params.require(:credit_card).permit(:email, :card_number, :expiry_date, :cvv)
  end

  def set_order
    @order = current_user.orders.find(params[:id])
  end

end
