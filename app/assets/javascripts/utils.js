var Utils = {};

Utils.image_selector = function(selector) {
	var $input = $(selector);
	var $image = $input.closest('label').find('img');
	var reader = new FileReader();
	reader.onload = function(e) {
		$image.attr('src', e.target.result);
	};
	var onchange = function(e) {
		var file = this.files[0];
		reader.readAsDataURL(file);
	};
	$input.change(onchange);
};

Utils.loader = function() {
	var $loader = $('<div>', { class: 'loader' }).hide();
	$('body').css({ overflow: 'hidden' }).append($loader);
	setTimeout(function() {
		$loader.fadeIn();
	}, 100);
	return {
		hide: function() {
			$loader.fadeOut(function() {
				$('body').removeAttr('style');
				$loader.remove();
			});
		}
	};
};

Utils.loaderSubmit = function(form) {
	Utils.loader();
	form.submit();
};

Utils.notification = function(n_class, text) {
	var $notification = $('<div>', { class: 'notification', text: text }).addClass(n_class).hide();
	$('body').append($notification);
	setTimeout(function() {
		$notification.fadeIn(function() {
			setTimeout(function() {
				$notification.fadeOut(function() {
					$notification.remove();
				});
			}, 4000);
		});
	}, 100);
};

Utils.autonumeric = function() {
	$('input.autonumeric').autoNumeric('init', { aSep: '.', aDec: ',', aPad: false });
	$('input.autonumeric-price').autoNumeric('init', { aSep: '.', aDec: ',', aPad: 2 });
};

Utils.cont_mInc_fix = function($form) {
	var $button = $form.find('input[type="submit"]');
	var $area = $form.find('textarea');
	var down = false;
	$area.blur(function(e) {
		if (!down) cont_mInc();
	});
	$button.mousedown(function(e) {
		down = true;
	});
	$button.on('mouseup mouseout', function(e) {
		down = false;
	});
}

Utils.respond = function(e) {
	e.preventDefault();
	var $trigger = $(this);
	var comment_id = $trigger.attr('href');
	var user_id = $trigger.data('user-id');
	var $root = $trigger.closest('.rootComment');
	var $form = $('<form>', { action: '/comments', class: 'new_comment_comment', method: 'post' })
	.append($('<input>', { type: 'hidden', name: 'comment[commentable_id]', value: comment_id }))
	.append($('<input>', { type: 'hidden', name: 'comment[commentable_type]', value: 'Comment' }))
	.append($('<input>', { type: 'hidden', name: 'comment[user_id]', value: user_id }))
	.append($('<textarea>', { type: 'text', name: 'comment[text]', placeholder: 'Escribe tu consulta aquí…', required: 'required', maxlength: 540 }))
	.append($('<input>', { type: 'submit', value: '✓' }))
	.append($('<button>', { type: 'reset', text: 'x' }));
	$('form.new_comment_comment').remove();
	$form.validate({
		submitHandler: function(form) {
			var loader = Utils.loader();
			$(form).remove();
			$.post($(form).attr('action'), $(form).serialize(), loader.hide, 'script');
		}
	});
	$root.append($form);
	$form.find('textarea').focus();
	$form.find('button[type=reset]').click(function() {
		$form.remove();
	});
};