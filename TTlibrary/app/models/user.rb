class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :books, through: :requests
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
