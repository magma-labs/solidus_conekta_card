# frozen_string_literal: true

Spree::CheckoutController.class_eval do
  def update
    if update_order
      assign_temp_address

      if params[:conektaTokenId]
        @order.payments.last.source.update_attributes(gateway_payment_profile_id: params[:conektaTokenId])
      end

      unless transition_forward
        redirect_on_failure
        return
      end

      if @order.completed?
        finalize_order
      else
        send_to_next_state
      end

    else
      render :edit
    end
  end
end
