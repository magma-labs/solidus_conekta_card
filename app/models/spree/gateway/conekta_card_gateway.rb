require 'conekta'

module Spree
  class Gateway::ConektaCardGateway < Spree::CreditCard
    attr_accessor :server, :test_mode, :auth_token, :public_auth_token, :source_method

    def purchase(money, source, gateway_options)
      ::Conekta.api_key = auth_token ? auth_token : ''
      ::Conekta.api_version = '2.0.0'

      begin
        order = Spree::Order.find(gateway_options[:originator].order_id)

        unless order.conekta_order_id
          conekta_order = ::Conekta::Order.create(payload(order, source))
        end

        conekta_order = ::Conekta::Order.find(order.conekta_order_id)
        ActiveMerchant::Billing::Response.new(true, 'Orden creada satisfactoriamente', {}, parse_response(conekta_order))
      rescue ::Conekta::Error => error
        ActiveMerchant::Billing::Response.new(false, error.details.map(&:message).join(', '))
      end
    end

    def name
      'Conekta Card'
    end

    private

    def payload(order, source)
      {
        currency: 'MXN',
        customer_info: {
          name: order.ship_address.full_name,
          email: order.email,
          phone: order.ship_address.phone
        },
        charges: [
          {
            payment_method: {
              type: 'card',
              token_id: source.gateway_payment_profile_id
            }
          }
        ],
          line_items: order_line_items(order),
          shipping_lines: shipping_lines(order),
          shipping_contact: {
            address: {
              street1: order.ship_address.address1,
              postal_code: order.ship_address.zipcode,
              country: 'MX'
          }
        }
      }
    end

    def order_line_items(order)
      order.line_items.map { |li| {name: li.product.name, unit_price: (li.price * 100).to_i, quantity: li.quantity} }
    end

    def parse_response(response)
      {
        conekta_order_id: response.id
      }
    end

    def shipping_lines(order)
      order.shipments.map {|s| {id: s.id, carrier: s.shipping_method.name, amount: (s.cost * 100).to_i} }
    end
  end
end
