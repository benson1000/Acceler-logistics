class Companies::OrdersController < ApplicationController
   before_action :authenticate_company!
   def new
      order = current_company.orders.build  
    end
    def create
        @order = current_company.orders.build(order_params)
        # Additional logic to save the order, send notifications, etc.

        if @order.save
          flash[:success] = 'Order placed successfully!'
          redirect_to order_path(@order)
        else
          flash.now[:danger] = 'Failed to place the order'
          render :new
        end
    end

    private

    def order_params
      params.require(:order).permit(:pickup_address, :delivery_address, :item_description, :quantity, :special_instructions)
    end
end
