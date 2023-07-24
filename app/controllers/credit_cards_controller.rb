class CreditCardsController < ApplicationController
  def new
    @credit_card = CreditCard.new
  end
  def create
    @credit_card = CreditCard.new(credit_card_params)

    if @credit_card.save
      # Credit card successfully saved, perform desired actions
      flash[:success] = "Successfully created..."
      redirect_to @credit_card
    else
      render :new
    end
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:email, :card_number, :expiry_date, :cvv)
  end
end
