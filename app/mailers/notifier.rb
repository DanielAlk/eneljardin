class Notifier < ApplicationMailer

	def notify_admin(object, special = nil)
		admin_email = ENV['notifications_mailer_to']
		case object.class.name
		when 'Contact'
			@contact = object
			mail(to: admin_email, subject: contact_subject_by_kind(@contact.kind))
		when 'Payment'
			@payment = object
			@notification = special.try(:to_sym) == :notification
			mail(to: admin_email, subject: 'Compra en eneljardin.com.ar')
		end
	end

	def notify_user(object, special = nil)
		case object.class.name
		when 'Payment'
			@payment = object
			@notification = special.try(:to_sym) == :notification
			mail(to: @payment.user.email, subject: 'Resumen de compra eneljardin.com.ar')
		end
	end

	private
		def contact_subject_by_kind(kind)
			{
				contact: 'Contacto',
				newsletter: 'Inscripción a Newsletter'
			}[kind.try(:to_sym)]
		end

end
