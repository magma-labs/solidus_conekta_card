# frozen_string_literal: true

module Spree
  class PaymentMethod::ConektaCard < PaymentMethod::CreditCard
    preference :auth_token, :string
    preference :public_auth_token, :string
    preference :source_method, :string, default: 'card'

    def auto_capture
      true
    end

    def partial_name
      'conekta_card'
    end

    def gateway_class
      Spree::Gateway::ConektaCardGateway
    end

    def payment_source_class
      Spree::Gateway::ConektaCardGateway
    end

    def payment_profiles_supported?
      false
    end
  end
end
