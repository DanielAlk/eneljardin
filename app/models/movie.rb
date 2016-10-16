class Movie < ActiveRecord::Base
	has_attached_file :image, styles: { large: "769x606#", medium: '714x513#', small: "272x195#", thumb: "105x75#" }
	validates_attachment :image, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }

	has_many :comments, as: :commentable, dependent: :destroy

	enum level: [ :beginner, :intermediate, :advanced, :professional ]

	def level=(level)
	  write_attribute(:level, level.to_i)
	end

	def price=(price)
	  write_attribute(:price, price.gsub('.', '').gsub(',', '.'))
	end
end
