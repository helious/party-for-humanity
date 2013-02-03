class AddMessageTable < ActiveRecord::Migration

  def change
  	create_table :messages
  	add_column :messages, :name, :string
  	add_column :messages, :email, :string
  	add_column :messages, :body, :text
  	add_column :messages, :sent, :boolean, :default => false
  end

end
