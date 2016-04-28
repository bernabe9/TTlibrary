class AddAttachmentImgToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :books, :img
  end
end
