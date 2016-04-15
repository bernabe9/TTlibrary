class AddIndexToBook < ActiveRecord::Migration
  def change
  	add_index :books, :author_id
  end
end
