var Utils = {};

Utils.init = function() {
	$(document).on('submit', 'form[data-util="loader"]', Utils.loader);
	$(document).on('click', 'a[data-util="loader"], button[data-util="loader"]', Utils.loader);
};

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
	var $loader = $('body>div.loader');
	var show = function() {
		$loader = $('<div>', { class: 'loader' }).hide();
		$('body').addClass('overflow-hidden').append($loader);
		setTimeout(function() {
			$loader.fadeIn();
		}, 100);
	};
	var hide = function() {
		$loader.fadeOut(function() {
			$('body').removeClass('overflow-hidden');
			$loader.remove();
		});
	};
	if (!$loader.length) show();
	return { element: $loader, hide: hide, show: show };
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

$(Utils.init);