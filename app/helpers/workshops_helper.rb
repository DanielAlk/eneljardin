module WorkshopsHelper
	def workshop_buy_button(workshop)
		if user_signed_in?
			if current_user.admin?
				link_to 'IR AL AULA', classroom_videos_path, class: 'btn_m-gr'
			else
				if workshop.is_owned_by?(current_user)
					if workshop.status_for(current_user) == :approved
						link_to 'IR AL AULA', classroom_videos_path, class: 'btn_m-gr'
					else
						link_to 'VER MIS PAGOS', payments_path, class: 'btn_m-gr'
					end
				else
					link_to 'COMPRAR', payments_path, data: { util: :mp, params: {payment: { user_id: current_user.id, workshop_id: workshop.id }} }, class: 'btn_m-gr'
				end
			end
		else
			if action_name.to_sym == :workshops
				link_to 'COMPRAR', workshop_page_path(workshop), class: 'btn_m-gr'
			else
				link_to 'COMPRAR', new_user_session_path, class: 'btn_m-gr'
			end
		end
	end
end
