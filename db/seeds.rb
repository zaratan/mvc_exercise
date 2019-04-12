# frozen_string_literal: true

1.upto(10) do |i|
  Item.create!(
    original_price: Faker::Number.decimal(2)
  )
  Rails.logger.info("ITEM #{i} : créé")
end
