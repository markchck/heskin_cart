class Order < ApplicationRecord
  belongs_to :user
  enum status: [:before_payment, :processed, :completed, :failed]
  
  has_many :order_items, dependent: :destroy
  has_many :packs, through: :order_items
  
end
