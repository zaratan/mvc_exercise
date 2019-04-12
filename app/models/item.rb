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
  include ActiveModel::Validations

  validates :original_price, presence: true, numericality: { greater_than: 0 }
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than: 100 }
  validates_with Validators::Discount

  before_save :toggle_has_discount_if_necessary

  def price
    if has_discount
      (original_price - (discount_percentage * original_price / 100))
    else
      original_price
    end.round(2)
  end

  def self.average_price
    return if Item.count.zero?

    Item.average("original_price * (100 - discount_percentage)/100").round(2)
  end

  private

  def toggle_has_discount_if_necessary
    return unless discount_percentage_changed?

    if discount_percentage.zero? || discount_percentage.nil?
      self.has_discount = false
      self.discount_percentage = nil
    else
      self.has_discount = true
    end
  end
end
