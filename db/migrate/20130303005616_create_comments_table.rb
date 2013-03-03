class CreateCommentsTable < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  		t.date :date
  		t.string :name
  		t.text :body
  		t.integer :party_id
  	end

  	add_index :comments, :party_id
  	add_index :annoucements, :party_id
  end
end
