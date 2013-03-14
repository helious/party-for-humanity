class ChangeDateColumnInCommentsTableFromDateToDateTime < ActiveRecord::Migration
  def change
  	change_column :comments, :date, :timestamp
  end
end
