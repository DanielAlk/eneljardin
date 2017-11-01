class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_attached_file :avatar, styles: { medium: "270x270#", small: "130x130#", thumb: "34x34#" }, default_url: "profile/avatar-:style.jpg"
	#validates_attachment :avatar, presence: true, content_type: { content_type: /\Aimage\/.*\Z/ }, size: { less_than: 1.megabytes }
	validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }

	has_many :payments, :dependent => :destroy
	has_many :workshops, -> { where payments: { collection_status: :approved } }, through: :payments
	has_many :notes, through: :workshops

	enum role: [:user, :admin]

	def is_webmaster?
		email === ENV['webmaster_email']
	end

	def first_name
		name[/[^\s]+/]
	end

	def last_name
		name.sub(first_name + ' ', '') unless self.name[' '].nil?
	end

	def use_default_avatar=(boolean)
		avatar.destroy if boolean.try(:to_i) == 1
	end

	def use_default_avatar
		false
	end

	def renew_expiration_for=(workshop_id)
		payment = workshops.find(workshop_id).last_approved_payment_for(self)
		payment.created_at = DateTime.now - 1.minute
		payment.updated_at = DateTime.now - 1.minute
		payment.save
	end

	def expirate_for=(workshop_id)
		payment = workshops.find(workshop_id).last_approved_payment_for(self)
		payment.created_at = DateTime.now - 31.days
		payment.updated_at = DateTime.now - 31.days
		payment.save
	end
end
