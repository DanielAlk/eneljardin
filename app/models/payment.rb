class Payment < ActiveRecord::Base
	include Rails.application.routes.url_helpers
 	belongs_to :user
 	has_many :payment_workshops, :dependent => :destroy
 	has_many :workshops, through: :payment_workshops

 	validates_presence_of [:user, :payment_workshops]

	serialize :mercadopago_preference

  after_create :create_mercadopago_preference

  def self.find_mp(collection_id)
  	payment_info = $mp.get('/collections/notifications/' + collection_id)
	if payment_info['status'].try(:to_i) == 200
		payment = self.find(payment_info['response']['collection']['external_reference'])
		if payment.present?
			payment.collection_status = payment_info['response']['collection']['status']
			#payment.collection_status_detail = payment_info['response']['collection']['status_detail']
			payment.save
			return payment
		end
	end
	return false
  end

  def workshop
  	workshops.first
  end

  private
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
				external_reference: id,
				auto_return: :approved,
				back_urls: {
					success: back_payment_url(self),
					pending: back_payment_url(self),
					failure: back_payment_url(self)
				},
				notification_url: notifications_payments_url,
			}
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
