class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :favorites
  has_many :user, :through => :favorites
end
