class AddColumnsToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :number, :string
    add_column :charities, :donation_url, :string
  end
end
