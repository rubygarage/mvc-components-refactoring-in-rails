class ChargesController < ApplicationController
  def create
    CheckoutService.new(params).call
    redirect_to charges_path
  rescue Stripe::CardError => exception
    flash[:error] = exception.message
    redirect_to new_charge_path
  end
end