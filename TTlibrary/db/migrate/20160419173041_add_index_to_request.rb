class AddIndexToRequest < ActiveRecord::Migration
  def change
    add_index :requests, :book_id
    add_index :requests, :user_id
  end
end
