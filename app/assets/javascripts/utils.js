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

Utils.jtemplate = function(form, methodOfInsertion, callback) {
	methodOfInsertion = methodOfInsertion || 'prepend';
	var loader = Utils.loader();
	var $form = $(form);
	$.ajax({
		url: $form.attr('action'),
		method: $form.attr('method'),
		dataType: 'json',
		data: $form.serialize()
	})
	.done(function(response) {
		form.reset();
		var $template = Utils.createFromTemplate($($form.data('jtemplate')), response);
		$($form.data('list'))[methodOfInsertion]($template);
		callback($template);
		loader.hide();
	})
};

Utils.createFromTemplate = function($template, object) {
	var findAttr = function(location) {
		var keys = location.split('.');
		var obj = object;
		keys.forEach(function(key) {
			obj = obj[key];
		});
		return obj;
	}
	var evaluate = function(condition) {
		var condition_sides = condition.split(' == ');
		var side_one = findAttr(condition_sides[0]);
		var side_two = condition_sides[1].replace(/'/g, '');
		return side_one == side_two;
	};
	$template = $template.clone();
	$elements = $template.find('*');
	$elements.each(function() {
		var $this = $(this);
		var dsrc = $this.data('src');
		var dtext = $this.data('text');
		var dhref = $this.data('href');
		var did = $this.data('id');
		var drepeat = $this.data('repeat');
		var dif = $this.data('if');
		if (!dif || evaluate(dif)) {
			if (!!dsrc) $this.attr('src', findAttr(dsrc));
			if (!!dtext) $this.text(findAttr(dtext));
			if (!!dhref) $this.attr('href', findAttr(dhref));
			if (!!did) $this.attr('id', $this.attr('id') + findAttr(did));
			if (!!drepeat && !!findAttr(drepeat)) {
				findAttr(drepeat).forEach(function(r) {
					var $tm = Utils.createFromTemplate($template, r);
					$this.append($tm);
				});
			}
		} else if (!!dif) {
			$this.remove();
		};
	});
	return $template;
}

Utils.respond = function(user_id, $triggers) {
	$triggers = $triggers || $('.utils-respond');
	var trigger = function(e) {
		e.preventDefault();
		var $trigger = $(this);
		var comment_id = $trigger.attr('href');
		var $root = $trigger.closest('.s3_des-msg-mLst-mtxt');
		var $form = $('<form>', { action: '/comments', class: 'new_comment_comment', method: 'post', 'data-jtemplate': '#commentTemplate', 'data-list': '#comment_list_' + comment_id })
		.append($('<input>', { type: 'hidden', name: 'comment[commentable_id]', value: comment_id }))
		.append($('<input>', { type: 'hidden', name: 'comment[commentable_type]', value: 'Comment' }))
		.append($('<input>', { type: 'hidden', name: 'comment[user_id]', value: user_id }))
		.append($('<textarea>', { type: 'text', name: 'comment[comment]', placeholder: 'Escribe tu consulta aquí…', required: 'required', maxlength: 540 }))
		.append($('<input>', { type: 'submit', value: '✓' }))
		.append($('<button>', { type: 'reset', text: 'x' }));
		$('form.new_comment_comment').remove();
		$form.validate({
			submitHandler: function(form) {
				$(form).remove();
				Utils.jtemplate(form, 'append', function($template) {
					Utils.respond(user_id, $template.find('.utils-respond'));
				});
			}
		});
		$root.after($form);
		$form.find('textarea').focus();
		$form.find('button[type=reset]').click(function() {
			$form.remove();
		});
	};
	$triggers.click(trigger);
};

Utils.showMoreTemplate = function(trigger_selector, callback) {
	var $trigger = $(trigger_selector);
	var $template = $($trigger.data('template'));
	var $list = $($trigger.data('list'));
	var user_id = $trigger.data('user_id');
	var url = $trigger.data('url');
	var showMore = function(e) {
		e.preventDefault();
		var loader = Utils.loader();
		var page = $trigger.data('page');
		$.get(url + '?page=' + page, function(response) {
			console.log(response);
			$trigger.data('page', Number(page)+1);
			response.forEach(function(r) {
				var $tm = Utils.createFromTemplate($template, r);
				$list.append($tm);
				callback($tm);
			});
			loader.hide();
		}, 'json');
	};
	$trigger.click(showMore);
};