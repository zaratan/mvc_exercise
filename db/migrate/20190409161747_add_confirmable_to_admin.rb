class AddConfirmableToAdmin < ActiveRecord::Migration[5.2]
  # Note: You can't use change, as User.update_all will fail in the down migration
  def up
    change_table :admins, bulk: true do |t|
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.index :confirmation_token, unique: true
    end
  end

  def down
    remove_columns :admins, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
