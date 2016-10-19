class Movie < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged
	has_attached_file :image, styles: { large: "769x606#", medium: '714x513#', small: "272x195#", thumb: "105x75#" }, default_url: Proc.new{ |m| m.instance.vimeo[:thumbnail_url] }
	validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

	validates_presence_of [:workshop, :title, :description, :video_url, :price]

	belongs_to :workshop
	has_many :comments, as: :commentable, dependent: :destroy

	enum level: [ :beginner, :intermediate, :advanced, :professional ]

	serialize :vimeo
	
	before_save :get_vimeo_metadata

	def level=(level)
	  write_attribute(:level, level.to_i)
	end

	def price=(price)
	  write_attribute(:price, price.gsub('.', '').gsub(',', '.'))
	end

	def image_from_vimeo=(boolean)
		image.destroy if boolean.try(:to_i) == 1
	end

	def image_from_vimeo
		image.blank?
	end

	private
		def get_vimeo_metadata
			uri = URI.parse('https://vimeo.com/api/oembed.json')
			params = { url: video_url }
			uri.query = URI.encode_www_form(params)

			res = Net::HTTP.get_response(uri)
			self.vimeo = JSON.parse(res.body).try(:symbolize_keys)
		end

		def should_generate_new_friendly_id?
			title_changed?
		end

		def slug_candidates
			[
				:title,
				[ :title, :id ]
			]
		end
end
