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

  scope :all, :default => true
  scope :active_products do |products|
    products.where(:status => false)
  end
  scope :inactive_products do |products|
    products.where(:status => true)
  end
  
  form do |f|
    text_node javascript_include_tag Ckeditor.cdn_url
    
    f.inputs do
      f.input :title #, :as => :ckeditor
      f.input :price
      f.input :image_file_name
      f.input :status
      f.input :image , :as => :file 
      f.input :description, :as => :ckeditor, input_html: { ckeditor: { height: 200 }, style: "margin-left: 20%" } 
    end
    f.actions
  end

  #   index :as => :grid do |product|
  #   div do
  #     resource_selection_cell product
  #     a :href => admin_product_path(product) do
  #       image_tag(product.image_url(:thumb))
  #     end
  #   end
  #   a truncate (product.title), :href => admin_product_path(product)
  # end

  show :title => :title

  sidebar :product_stats, :only => :show do
    attributes_table_for resource do
      row("Total Sold")  { Order.find_with_product(resource).count }
      row("Dollar Value"){ number_to_currency LineItem.where(:product_id => resource.id).sum(:total_price) }
    end
  end

  sidebar :recent_orders, :only => :show do
    Order.find_with_product(resource).limit(5).collect do |order|
      auto_link(order)
    end.join(content_tag("br")).html_safe
  end
end
