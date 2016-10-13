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