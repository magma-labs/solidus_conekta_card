# frozen_string_literal: true

class CreateConektaCardPayments < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_conekta_card_payments do |t|
      t.string :conekta_order_id
    end
  end
end
