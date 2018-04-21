class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :favirites
  has_many :user, :through => :favirites
end
