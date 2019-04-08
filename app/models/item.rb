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

  def price
    if has_discount
      (original_price - original_price * discount_percentage.to_f / 100).round(2)
    else
      original_price
    end
  end

  def self.average_price
    self.all.map{|item| item.price }.sum / self.count
  end
end
