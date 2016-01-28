require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog'

CarrierWave.configure do |config|
  config.fog_credentials = {

    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['S3_SECRET_ACCESS_KEY'],
    :region                => 'ap-southeast-2'
    # :host   => 's3-ap-southeast-2.amazonaws.com'
  }
    config.storage = :fog
  config.fog_directory    = 'gruelintentions'
  #connect to host route and make a directory to store images in temporarily. Need a constant var 
  config.cache_dir = "../tmp/uploads"
end

class ImageUploader < CarrierWave::Uploader::Base

end

class Dish < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
	has_many :likes

	validates :name, presence: true
	validates :name, length: { minimum: 2}
end 
