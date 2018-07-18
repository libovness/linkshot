class AddShotToLinks < ActiveRecord::Migration[5.1]
  def change
    add_reference :links, :shot, foreign_key: true
  end
end
