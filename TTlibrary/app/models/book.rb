class Book < ActiveRecord::Base
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :users, through: :requests
end
