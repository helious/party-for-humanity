class AddGoalToParties < ActiveRecord::Migration
  def change
    add_column :parties, :goal, :float
  end
end
