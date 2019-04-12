# frozen_string_literal: true

module Validators
  class Discount < ActiveModel::Validator
    def validate(record)
      return unless record.has_discount_changed? || record.id.nil?

      if no_discount_flag_but_discount?(record)
        record.errors[:has_discount] << "Cannot have a 'has_discount' value to false if there's a discount_percentage."
      end

      return unless discount_flag_but_no_discount?(record)

      record.errors[:has_discount] << "Cannot have a 'has_discount' value to true if there's no discount_percentage."
    end

    private

    def no_discount_flag_but_discount?(record)
      !record.has_discount && !record.discount_percentage.zero? && !record.discount_percentage.nil?
    end

    def discount_flag_but_no_discount?(record)
      record.has_discount && (record.discount_percentage.zero? || record.discount_percentage.nil?)
    end
  end
end
