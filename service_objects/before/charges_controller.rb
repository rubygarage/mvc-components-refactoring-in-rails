class ChargesController < ApplicationController
  def create
    amount = params[:amount].to_i * 100

    customer = Stripe::Customer.create(
      email: params[:email],
      source: params[:source]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: params[:description],
      currency: params[:currency] || 'USD'
    )

    redirect_to charges_path
  rescue Stripe::CardError => exception
    flash[:error] = exception.message
    redirect_to new_charge_path
  end
end