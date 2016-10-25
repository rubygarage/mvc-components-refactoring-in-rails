class CheckoutInteractor
  def self.call(context)
    interactor = new(context)
    interactor.run
    interactor
  end

  attr_reader :error

  def initialize(context)
    @context = context
  end

  def success?
    @error.nil?
  end

  def run
    CheckoutService.new(context.params)
  rescue Stripe::CardError => exception
    fail!(exception.message)
  end

  private

  attr_reader :context

  def fail!(error)
    @error = error
  end
end