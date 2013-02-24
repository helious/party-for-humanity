class AddGuestsTable < ActiveRecord::Migration
	def change
		create_table :guests
  		add_column :guests, :name, :string
	  	add_column :guests, :email, :string
	  	add_column :guests, :city, :string
	  	add_column :guests, :state, :string
	  	add_column :guests, :zip, :string
	    add_column :guests, :address, :string
	  	add_column :guests, :rsvp, :boolean
	  	add_column :guests, :donation, :float
	  	add_column :guests, :party_id, :integer

  		add_index :guests, :party_id
	end
end
