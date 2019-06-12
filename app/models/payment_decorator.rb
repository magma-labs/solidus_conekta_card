module ConektaCard
  module Payment
    extend ActiveSupport::Concern

    def conekta?
      self.payment_method.type.include? 'Conekta'
    end
  end
end

Spree::Payment.include ConektaCard::Payment
