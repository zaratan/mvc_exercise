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

class DiscountValidation < ActiveModel::Validator
  def validate(record)
    if record.has_discount_changed? || record.id.nil?
      if !record.has_discount && !record.discount_percentage == 0 && !record.discount_percentage.nil?
        record.errors[:has_discount] << "Cannot have a 'has_discount' value to false if there's a discount_percentage."
      end
      if record.has_discount && (record.discount_percentage == 0 || record.discount_percentage.nil?)
        record.errors[:has_discount] << "Cannot have a 'has_discount' value to true if there's no discount_percentage."
      end
    end
  end
end

class Item < ApplicationRecord
  include ActiveModel::Validations

  validates :original_price, presence: true, numericality: { greater_than: 0 }
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than: 100}
  validates_with DiscountValidation

  before_save :toggle_has_discount_if_necessary

  def price
    if has_discount
      (original_price - (discount_percentage * original_price / 100)).truncate(2)
    else
      original_price
    end
  end

  private

  def toggle_has_discount_if_necessary
    if discount_percentage_changed?
      if discount_percentage == 0 || discount_percentage.nil?
        has_discount = false
        discount_percentage = nil
      else
        has_discount = true
      end
    end
  end

end
