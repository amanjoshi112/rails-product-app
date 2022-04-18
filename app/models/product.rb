class Product < ApplicationRecord
	enum status: [:active, :inactive]
  	mount_uploader :image, ImageUploader

  	THUMB_WIDTH = 220
  	PREVIEW_WIDTH = 460
  	MAX_WIDTH = 960
end
