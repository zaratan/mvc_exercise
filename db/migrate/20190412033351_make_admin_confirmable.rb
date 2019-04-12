# frozen_string_literal: true

class MakeAdminConfirmable < ActiveRecord::Migration[5.2]
  def change
    change_table :admins, bulk: true do |t|
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
    end
  end
end
