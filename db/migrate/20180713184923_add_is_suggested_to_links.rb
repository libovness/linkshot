class AddIsSuggestedToLinks < ActiveRecord::Migration[5.1]
  def change
  	add_column :links, :suggested, :boolean
  	add_column :links, :accepted, :boolean
  end
end
