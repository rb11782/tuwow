class Wow < ApplicationRecord
 validates :comment, presence: true
 # validates :picture, presence: true
 has_many :locations
 mount_uploader :picture, PictureUploader
 belongs_to :user
end
