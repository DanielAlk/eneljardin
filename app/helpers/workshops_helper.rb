module WorkshopsHelper
	def workshop_buy_button(workshop)
		if user_signed_in?
			link_to 'COMPRAR', payments_path, data: { util: :mp, params: {payment: { user_id: current_user.id, workshop_id: workshop.id }} }, class: 'btn_m-gr'
		else
			link_to 'COMPRAR', new_user_session_path, class: 'btn_m-gr'
		end
	end
end
