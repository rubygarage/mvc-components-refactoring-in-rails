class CheckoutService
  DEFAULT_CURRENCY = 'USD'.freeze

  def initialize(options = {})
    options.each_pair do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def call
    Stripe::Charge.create(charge_attributes)
  end

  private

  attr_reader :email, :source, :amount, :description

  def currency
    @currency || DEFAULT_CURRENCY
  end

  def amount
    @amount.to_i * 100
  end

  def customer
    @customer ||= Stripe::Customer.create(customer_attributes)
  end

  def customer_attributes
    {
      email: email,
      source: source
    }
  end

  def charge_attributes
    {
      customer: customer.id,
      amount: amount,
      description: description,
      currency: currency
    }
  end
end