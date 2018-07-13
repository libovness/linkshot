class CreateShots < ActiveRecord::Migration[5.1]
  def change
    create_table :shots do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end
  end
end
