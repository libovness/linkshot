class AddPublishedToShots < ActiveRecord::Migration[5.1]
  def change
    add_column :shots, :published, :boolean, :default => true
  end
end
