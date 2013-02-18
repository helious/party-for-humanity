class AddIndexAndUniqueToProfilesUsername < ActiveRecord::Migration
  def change
  	add_index :profiles, :username, :unique => true
  end
end
