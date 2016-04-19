class AddIndexToComment < ActiveRecord::Migration
  def change
  	add_index :comments, :book_id 
  end
end
