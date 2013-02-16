class AddProfilesTable < ActiveRecord::Migration
  def change
  	create_table :profiles
  	add_column :profiles, :username, :string
  	add_column :profiles, :name, :string
  	add_column :profiles, :zipcode, :text
  	add_column :profiles, :user_id, :integer
  end
end
