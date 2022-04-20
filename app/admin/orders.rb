ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :checked_out_at, :total_price
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :checked_out_at, :total_price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  menu :priority => 3
  actions :index, :show

  filter :total_price
  filter :checked_out_at

  scope :all, :default => true
  scope :in_progress
  scope :complete

  index do
    column("Order", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
    column("Status")                   {|order| status_tag(order.state) }
    column("Date", :checked_out_at)
    column("Customer", :user, :sortable => :user_id)
    column("Total")                   {|order| number_to_currency order.total_price }
  end

  show do
    panel "Invoice" do
      table_for(order.line_items) do |t|
        t.column("Product") {|item| auto_link item.product        }
        t.column("Price")   {|item| number_to_currency item.total_price }
        tr :class => "odd" do
          td "Total:", :style => "text-align: right;"
          td number_to_currency(order.total_price)
        end
      end
    end
  end

  sidebar :customer_information, :only => :show do
    attributes_table_for order.user do
      row("User") { auto_link order.user }
      row :email
    end
  end

  
end
