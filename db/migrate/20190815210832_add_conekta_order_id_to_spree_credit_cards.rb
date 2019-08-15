# frozen_string_literal: true

class AddConektaOrderIdToSpreeCreditCards < SolidusSupport::Migration[5.2]
  def change
     add_column :spree_credit_cards, :conekta_order_id, :string
  end
end
