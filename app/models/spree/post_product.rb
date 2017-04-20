class Spree::PostProduct < ActiveRecord::Base

  belongs_to :post
  belongs_to :product

  validates_presence_of :post
  validates_presence_of :product

end
