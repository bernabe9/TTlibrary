class Request < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  enum status: [ :Waiting, :Accepted, :Denied ]

  scope :waiting, -> { where(status: 0) }
  scope :accepted, -> { where(status: 1) }
  scope :denied, -> { where(status: 2) }
  
end
