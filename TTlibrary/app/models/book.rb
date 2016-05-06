class Book < ActiveRecord::Base
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :users, through: :requests

  validates :title, :description, :year, :ISBN, :author_id, presence: true

  has_attached_file :img, :styles => { :small => "150x150", :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing_img.jpg"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\Z/
  
end
