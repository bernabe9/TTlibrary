class RemoveImgColumnsToBooks < ActiveRecord::Migration
  def self.up
    remove_attachment :books, :img   
  end

  def self.down
    remove_attachment :books, :img   
  end 
end
