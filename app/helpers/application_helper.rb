module ApplicationHelper
	def nav_class(action)
		'activo' if action == action_name.to_sym
	end
end
