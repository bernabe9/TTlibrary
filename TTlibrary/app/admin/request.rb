ActiveAdmin.register Request, as: 'Request Books' do
  permit_params :status, :book_id, :user_id

  actions :all, :except => [:new, :create]

  index do
    selectable_column
    id_column
    column :book
    column :user
    column :created_at
    column :status, sortable: false
    actions
  end

  scope :all, default: true
  scope :waiting
  scope :accepted
  scope :denied

  filter :user, collection: proc { User.pluck(:email) }
  filter :book
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "Details" do
      #f.input :book
      #f.input :user, collection: User.pluck(:email), include_blank: false
      f.input :status
    end
    f.actions
  end 

end
