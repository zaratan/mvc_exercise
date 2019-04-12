# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    @items = Item.order(:created_at).first(100)
  end
  layout 'administration'
end
