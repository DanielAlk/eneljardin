class Workshop < ActiveRecord::Base
	include Tinymce
	has_attached_file :image, styles: { large: "769x606#", medium: '714x513#', small: "272x195#", thumb: "105x75#" }
	validates_attachment :image, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }

	validates_presence_of [:title, :description, :information, :price]
	tinymce column: :information

	has_many :movies, dependent: :destroy

	enum level: [ :beginner, :intermediate, :advanced, :professional ]

	def level=(level)
	  write_attribute(:level, level.to_i)
	end

	def price=(price)
	  write_attribute(:price, price.gsub('.', '').gsub(',', '.'))
	end
end
