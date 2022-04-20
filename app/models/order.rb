class Order < ApplicationRecord
	has_many :line_items, :dependent => :destroy
  	belongs_to :user

  	  COMPLETE = "complete"
      IN_PROGRESS = "in_progress"

     scope :in_progress, ->{where("orders.checked_out_at IS NULL")}
  scope :complete, -> {where("orders.checked_out_at IS NOT NULL")}


  def self.find_with_product(product)
    return [] unless product
    complete.joins(:line_items).where(["line_items.product_id = ?", product.id]).order("orders.checked_out_at DESC")
  end

  def checkout!
    self.checked_out_at = Time.now
    self.save
  end

  def recalculate_price!
    self.total_price = line_items.inject(0.0){|sum, line_item| sum += line_item.total_price }
    save!
  end

  def state
    checked_out_at.nil? ? IN_PROGRESS : COMPLETE
  end

  def display_name
    ActionController::Base.helpers.number_to_currency(total_price) +
        " - Order ##{id} (#{user.email})"
  end
end
