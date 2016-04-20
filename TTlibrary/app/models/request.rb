class Request < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  enum status: [ :waiting, :acepted, :denied ]
end
