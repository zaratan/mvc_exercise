# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action { current_admin || authenticate_user! }

  def index
    @items = Item.order(:created_at).first(100)
    @average = Item.average_price
  end
  layout 'administration'
end
