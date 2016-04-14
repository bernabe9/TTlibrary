class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :year
      t.integer :ISBN

      t.timestamps null: false
    end
  end
end
