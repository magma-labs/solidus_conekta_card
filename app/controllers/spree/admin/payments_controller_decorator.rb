# frozen_string_literal: true

module AdminPaymentsDecorator
  extend ActiveSupport::Concern

  included do
    def create
      @payment = Spree::PaymentCreate.new(@order, object_params).build
      if @payment.payment_method.source_required? && params[:card].present? && params[:card] != 'new'
        @payment.source = @payment.payment_method.payment_source_class.find_by(id: params[:card])
      end

      if @payment.save
        if @order.completed?
          # If the order was already complete then go ahead and process the payment
          # (auth and/or capture depending on payment method configuration)
          if params[:conektaTokenId]
            @order.payments.last.source.update_attributes(gateway_payment_profile_id: params[:conektaTokenId])
          end
          @payment.process! if @payment.checkout?
        else
          # Transition order as far as it will go.
          while @order.next; end
        end

        flash[:success] = flash_message_for(@payment, :successfully_created)
        redirect_to admin_order_payments_path(@order)
      else
        flash[:error] = t('spree.payment_could_not_be_created')
        render :new
      end
    rescue Spree::Core::GatewayError => e
      flash[:error] = e.message.to_s
      redirect_to new_admin_order_payment_path(@order)
    end
  end
end

Spree::Admin::PaymentsController.include(AdminPaymentsDecorator)
