# frozen_string_literal: true

class AddTimeStampToConektaCardPayment < SolidusSupport::Migration[4.2]
  def change
    change_table :spree_conekta_card_payments do |t|
      t.timestamps
    end
  end
end
