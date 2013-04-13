class AddAnonymousDonationToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :anonymous_donation, :boolean
  end
end
