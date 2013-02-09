class AddCharityTable < ActiveRecord::Migration
	
  def change
  	create_table :charities
  	add_column :charities, :name, :string
  	add_column :charities, :description, :text
  	add_column :charities, :category, :string
  	add_column :charities, :website, :string
  end

end
