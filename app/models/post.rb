class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :favorites
  has_many :favorite_user, :through => :favorites, source: :user
end
