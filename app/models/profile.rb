class Profile < ApplicationRecord
  
  belongs_to :user

  validates_presence_of :name, :surname, :age, :gender, :image
  mount_uploader :image, ImageUploader
end
