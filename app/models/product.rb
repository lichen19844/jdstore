class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  def self.search(searcher)
    where("title LIKE ?", "%#{searcher}%").or(where("description LIKE ?", "%#{searcher}%"))
  end

  has_many :photos
  accepts_nested_attributes_for :photos

  belongs_to :category, optional: true

  has_many :favorites

  has_many :members, :through => :favorites, :source => :user

  has_many :users

end
