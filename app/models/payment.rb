class Payment < ActiveRecord::Base
	include Rails.application.routes.url_helpers
 	belongs_to :user
 	belongs_to :workshop

 	validates_presence_of [:user, :workshop]

	serialize :payment_info
	serialize :mercadopago_preference

  after_create :create_mercadopago_preference
  #before_update :manage_user_workshop, if: :collection_status_changed?

  scope :approved, -> { where(collection_status: :approved) }
  scope :in_process, -> { where(collection_status: [:in_process, :pending, :in_mediation]) }
  scope :rejected, -> { where(collection_status: [:rejected, :cancelled, :refunded, :charged_back]) }

  def self.find_mp(collection_id)
  	payment_info = $mp.get('/collections/notifications/' + collection_id)
		if payment_info['status'].try(:to_i) == 200
			payment = self.find(payment_info['response']['collection']['external_reference'])
			if payment.present?
				payment.payment_info = payment_info['response']['collection']
				payment.collection_id = payment.payment_info['id']
				payment.collection_status = payment.payment_info['status']
				payment.collection_status_detail = payment.payment_info['status_detail']
				payment.payment_type = payment.payment_info['payment_type']
				return payment
			end
		end
		return false
  end

  def approved?
  	collection_status.try(:to_sym) == :approved
  end
  def in_process?
  	[:in_process, :pending, :in_mediation].include? self.collection_status.try(:to_sym)
  end
  def rejected?
  	[:rejected, :cancelled, :refunded, :charged_back].include? self.collection_status.try(:to_sym)
  end

  private
  	def manage_user_workshop
  		status = collection_status.try(:to_sym)
  		status_was = collection_status_was.try(:to_sym)
  		if status_was == :approved && status == :in_mediation
  			#suspend user workshop
  		end
  		if status_was == :in_mediation && status == :approved
  			#enable user workshop
  		end
  		if [nil, :pending, :in_process, :rejected].include?(status_was) && status == :approved
  			#create user workshop
  		end
  		if [:approved, :in_mediation, :pending, :in_process].include?(status_was) && [:refunded, :charged_back, :cancelled, :rejected].include?(status)
  			#delete user workshop
  		end
  	end

	  def create_mercadopago_preference
	  	preference_data = {
	  		items: [
		  		{
		  			id: workshop.id,
						title: workshop.title,
						description: workshop.description,
						picture_url: workshop.image.url(:medium),
						category_id: "learnings",
						unit_price: workshop.price.to_f,
						quantity: 1,
						currency_id: :ARS
					}
				],
				payer: {
					name: user.first_name,
					surname: user.last_name,
					email: user.email
				},
				statement_descriptor: 'Taller online de eneljardin.com.ar',
				external_reference: id
			}
			if Rails.env.production? #mercadopago sandbox fails if localhost:3000 is in the notification_url
				preference_data[:notification_url] = notifications_payments_url
			end
			self.mercadopago_preference = $mp.create_preference(preference_data)['response']
			self.init_point = mercadopago_preference[mercadopago_init_point]
			self.transaction_amount = workshop.price
			self.save
		end

		def is_sandbox?
			ENV['mercadopago_sandbox_mode'] == 'true'
		end

		def mercadopago_init_point
			is_sandbox? ? 'sandbox_init_point': 'init_point'
		end
end
