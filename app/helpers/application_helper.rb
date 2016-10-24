module ApplicationHelper
	def nav_class(action)
		'activo' if action == action_name.to_sym
	end

	def scaffolds_size
		case controller_name.to_sym
		when :payments
			case action_name.to_sym
			when :index
				:large if user_signed_in? && current_user.admin?
			end
		end
	end

	def tinymce_init(height = 0)
		content_for :extra_js do
			"setTimeout(function() {
				if (!$('.tinymce').prev().is('.mce-panel')) window.location.reload();
			}, 500);".html_safe
		end
		"<script>
			tinyMCE.init({
				selector: 'textarea.tinymce',
				toolbar: 'bold italic | undo redo | link',
				menubar: false,
				statusbar: false,
				height: #{height},
				forced_root_block: false,
				plugins: 'link'
			});
		</script>".html_safe
	end
end
