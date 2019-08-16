# frozen_string_literal: true

module CheckoutControllerDecorator
  extend ActiveSupport::Concern

  included do
    prepend(InstanceMethods)
    after_action :assign_conekta_payment_profile, only: :update
  end

  module InstanceMethods
    private

    def assign_conekta_payment_profile
      return unless params[:conektaTokenId] && @order.payments.any?

      payment_source = @order.payments.last.source
      payment_source.update_attribute(:gateway_payment_profile_id,
                                      params[:conektaTokenId])
    end
  end
end

Spree::CheckoutController.include CheckoutControllerDecorator
