var Comments = {};

Comments.init = function() {
	$(document).on('click', '.utils-respond', Comments.respond);
};

Comments.respond = function(e) {
	e.preventDefault();
	var $trigger = $(this);
	var comment_id = $trigger.attr('href');
	var user_id = $trigger.data('user-id');
	var $root = $trigger.closest('.s3_des-msg-mLst-mtxt');
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
	$root.after($form);
	$form.find('button[type=reset]').click(function() {
		$form.remove();
	});
	setTimeout(function() {
		$form.find('textarea').focus();
	}, 100);
};

$(Comments.init);