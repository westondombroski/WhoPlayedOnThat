class CreateMusicians < ActiveRecord::Migration[5.0]
  def change
    create_table :musicians do |t|

      t.timestamps
    end
  end
end
