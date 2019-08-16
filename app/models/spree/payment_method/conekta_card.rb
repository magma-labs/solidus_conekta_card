# frozen_string_literal: true

module Spree
  class PaymentMethod::ConektaCard < Spree::PaymentMethod::CreditCard
    preference :auth_token, :string
    preference :public_auth_token, :string
    preference :source_method, :string, default: 'card'

    def source_required?
      true
    end

    def card?
      true
    end

    def auto_capture?
      true
    end

    def payment_source_class
      Spree::ConektaCardPayment
    end

    def gateway_class
      Spree::ConektaCardPayment
    end

    def partial_name
      'conekta_card'
    end
    alias_method :method_type, :partial_name
  end
end
