# frozen_string_literal: true

1.upto(10) do |i|
  item = Item.create!(
    original_price: Faker::Number.decimal(2),
    has_discount: Faker::Boolean.boolean
  )
  if item.has_discount
    item.discount_percentage = (1..10).to_a.sample * 5
    item.save
  end
  p "ITEM #{i} : créé"
end
