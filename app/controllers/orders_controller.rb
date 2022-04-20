class OrdersController < ApplicationController
  def index
    @orders= Order.where("user_id = ?",params[:user_id] ).order(id: :desc)
    #Order.joins(:line_items) left_outer_joins(:line_items)

    #LineItem.joins(:order).where(orders: {user_id :user_id } )
  end
end
