class AddIsCharitySuggestionColumnToMessages < ActiveRecord::Migration

  def change
    add_column :messages, :is_charity_suggestion, :boolean
  end

end
