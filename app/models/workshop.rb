class Workshop < ActiveRecord::Base
	extend FriendlyId
	include Tinymce
	friendly_id :slug_candidates, use: :slugged
	has_attached_file :image, styles: { large: "769x606#", medium: '714x513#', small: "272x195#", thumb: "105x75#" }
	validates_attachment :image, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }

	validates_presence_of [:title, :description, :information, :price]
	tinymce column: :information

	has_many :movies, dependent: :destroy
	has_many :notes, dependent: :destroy
	has_many :payments
	has_many :users, through: :payments

	enum level: [ :beginner, :intermediate, :advanced, :professional ]

	def level=(level)
	  write_attribute(:level, level.to_i)
	end

	def price=(price)
	  write_attribute(:price, price.gsub('.', '').gsub(',', '.'))
	end

	def is_owned_by?(user)
		self.payments.where(user: user, collection_status: [:approved, :in_process, :in_mediation]).present?
	end

	def status_for_user(user)
		user_payments = self.payments.where(user: user)
		if user_payments.approved.present?
			:approved
		elsif user_payments.in_process.present?
			:in_process
		elsif user_payments.rejected.present?
			:rejected
		end
	end

	private
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
