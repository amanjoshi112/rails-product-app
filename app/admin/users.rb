ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  menu priority: 4
  config.batch_actions = true

  filter :email
  filter :created_at

  permit_params :username, :email, :password

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    actions
  end

  show title: :email do
    panel "Order History" do
      table_for(user.orders) do
        column("Order", sortable: :id) do |order|
          link_to "##{order.id}", admin_order_path(order)
        end
        column("State") { |order| status_tag(order.state) }
        column("Date", sortable: :checked_out_at) do |order|
          pretty_format(order.checked_out_at)
        end
        column("Total") { |order| number_to_currency order.total_price }
      end
    end

    active_admin_comments
    end
end
