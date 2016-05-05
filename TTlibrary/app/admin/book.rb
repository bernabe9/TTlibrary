ActiveAdmin.register Book do
  permit_params :title, :year, :ISBN, :author_id, :img, :description

  index as: :grid do |book|
    a href: admin_book_path(book) do
        div image_tag(book.img.url(:medium))
        div book.title
    end
  end

=begin
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
=end

  filter :author, collection: proc { Author.pluck(:first_name) }
  filter :title
  filter :year
  filter :ISBN
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :title
      row :year
      row :ISBN
      row :description
      row :created_at
      row :updated_at
      row :author
      row :image do
        image_tag book.img.url(:medium)
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :author
      f.input :title
      f.input :year
      f.input :ISBN
      f.input :description
      f.input :img, as: :file
    end
    f.actions
  end 

end
