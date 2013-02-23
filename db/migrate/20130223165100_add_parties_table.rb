class AddPartiesTable < ActiveRecord::Migration
  def change
  	create_table :parties
  	add_column :parties, :name, :string
  	add_column :parties, :host, :string
  	add_column :parties, :party_type, :string
  	add_column :parties, :location, :string
  	add_column :parties, :city, :string
  	add_column :parties, :state, :string
  	add_column :parties, :zip, :string
    add_column :parties, :address, :string
  	add_column :parties, :phone_number, :string
  	add_column :parties, :date, :date
  	add_column :parties, :time, :time
  	add_column :parties, :message, :text
  	add_column :parties, :charity_id, :integer
  	add_column :parties, :user_id, :integer

  	add_index :parties, :user_id
  end
end
