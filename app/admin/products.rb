ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :price, :image_file_name, :status, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :price, :image_file_name, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f|
    text_node javascript_include_tag Ckeditor.cdn_url
    
    f.inputs do
      f.input :title, :as => :ckeditor
      f.input :price
      f.input :image_file_name
      f.input :status
      f.input :image , :as => :file 
      f.input :description, :as => :ckeditor, input_html: { ckeditor: { height: 200 }, style: "margin-left: 20%" } 
    end
    f.actions
  end

end
