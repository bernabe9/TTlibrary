ActiveAdmin.register Book do
  permit_params :title, :year, :ISBN, :author_id

  index do
    selectable_column
    id_column
    column :title
    column :year
    column :ISBN
    column :author
    column :created_at
    column :updated_at
    actions
  end

  filter :author, collection: proc { Author.pluck(:first_name) }
  filter :title
  filter :year
  filter :ISBN
  filter :created_at
  filter :updated_at

end
