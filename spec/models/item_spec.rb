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

require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'Model creation' do
    subject do
      create(:item)
    end

    it 'is creatable' do
      item = subject.reload
      expect(item.original_price).not_to be_nil
      # expect(item.has_discount).not_to be_nil
      # expect(item.discount_percentage).not_to be_nil
    end
  end

  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to validate_presence_of(:original_price) }
      it { is_expected.to validate_numericality_of(:original_price).is_greater_than(0) }
      it { is_expected.to validate_numericality_of(:discount_percentage).is_greater_than_or_equal_to(0).is_less_than(100) }

      it "isn't valid if the has_discount change while having a non-null discount_percentage" do
        item =  create(:item_with_discount, original_price: 100) 
        item.has_discount = false
        expect(item).not_to be_valid
      end

      it "isn't valid if we create an item with a false has_discount and an non-null discount_percentage" do
        item =  build(:item, discount_percentage: 50) 
        expect(item).not_to be_valid
      end
    end
  end

  describe 'Price' do
    context 'when the item has a discount' do
      context 'when the item price is divible by the discout_percentage' do
        let(:item) { build(:item_with_discount, original_price: 100) }
        it "returns the computed price" do
          expect(item.price).to eq(80)
        end
      end

      context 'when the item price is not divible by the discout_percentage' do
        let(:item) { build(:item_with_discount, original_price: 39.99) }
        it "returns a readable computed price, with 2 digits after coma" do
          expect(item.price).to eq(31.99)
        end
      end
    end
    context 'when the item has no discount' do
      let(:item) { build(:item) }
      it "returns the original price" do
        expect(item.price).to eq(item.original_price)
      end
    end

  end


end
