# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @emails = User.emails_of_all_users
      @items = Item.all
    end

    def update
      Item.update(params[:id], update_params)
      redirect_to administration_items_path
    end

    private

    def update_params
      params.require(:item).permit(:discount_percentage)
    end
  end
end
