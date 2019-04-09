# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Item < ApplicationRecord
  validates :original_price, numericality: { greater_than: 0.0 }
  validates :original_price, presence: { message: "Original price must be present" }
  validates :discount_percentage, inclusion: { in: 0..100 }
  validates :discount_percentage, numericality: true

  def price
    has_discount ? (original_price - (original_price * discount_percentage.to_f / 100.0)).round(2) : original_price
  end

  def self.average_price
    array_pricing = []
    Item.find_each { |el| array_pricing << el.original_price }
    array_pricing.sum / array_pricing.length unless array_pricing.length.zero?
  end
end
