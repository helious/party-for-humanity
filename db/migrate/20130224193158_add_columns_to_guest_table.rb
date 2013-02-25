class AddColumnsToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :invite_sent, :boolean, :default => true
  end
end
