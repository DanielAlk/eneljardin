module HeadHelper
	def head_allow_robots?
		true
	end

	def head_title
		case action_name.to_sym
		when :welcome
			'Bienvenidos | Clara Billoch'
		when :workshops
			'Talleres Online | Clara Billoch'
		when :bouquets
			'Ramos | Clara Billoch'
		when :face_workshops
			'Talleres Presenciales | Clara Billoch'
		when :publications
			'Publicaciones | Clara Billoch'
		when :contact
			'Contacto | Clara Billoch'
		else
			'Clara Billoch'
		end
	end

	def head_description
		''
	end

	def head_og_image
		asset_url 'logo.jpg'
	end

	def head_og_image_width
		'102'
	end

	def head_og_image_height
		'130'
	end
end
