# frozen_string_literal: true

require "json"

# Sample class with various syntax elements
module Shop
  TAX_RATE = 0.11
  STATUSES = %i[pending paid shipped].freeze

  class Order < ApplicationRecord
    attr_reader :items, :status
    belongs_to :customer, optional: true

    def initialize(items = [], status: :pending)
      @items = items
      @status = status
    end

    # Calculate the total including tax
    def total(discount = 0)
      subtotal = items.sum { |item| item[:price] * item[:qty] }
      (subtotal - discount) * (1 + TAX_RATE)
    end

    def label
      return "Empty" if items.empty?

      case status
      when :paid then "Paid: #{format('%.2f', total)}"
      when :shipped then 'Shipped'
      else "Pending (#{items.size} items)"
      end
    end

    def self.parse(json_text)
      data = JSON.parse(json_text, symbolize_names: true)
      new(data[:items] || [], status: data.fetch(:status, :pending))
    rescue JSON::ParserError => e
      warn "Failed to parse: #{e.message}"
      nil
    end
  end
end

order = Shop::Order.parse('{"items": [{"price": 12.5, "qty": 3}]}')
puts order&.label if order && order.total > 0
puts "Valid email" if "a@b.com" =~ /\A[\w+.-]+@[\w-]+\.\w+\z/
