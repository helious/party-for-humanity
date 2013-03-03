class CreateAnnoucementTable < ActiveRecord::Migration
  def change
  	create_table :annoucements do |t|
  		t.text :body
  		t.integer :party_id
  	end

  	add_column :parties, :end_time, :time
  end
end
