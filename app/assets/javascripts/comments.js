var Comments = {};

Comments.init = function() {
	$(document).on('click', '.comment-controls-trigger', Comments.showControls);
	$(document).on('click', '.comment-controls-options', Comments.avoidHiding);
	$(document).click(Comments.hideAllControls);
};

Comments.showControls = function(e) {
	e.preventDefault();
	e.stopImmediatePropagation();
	Comments.hideAllControls();
	$(this).closest('.comment-controls').addClass('active');
};

Comments.avoidHiding = function(e) {
	e.stopImmediatePropagation();
};

Comments.hideAllControls = function(e) {
	$('.comment-controls.active').removeClass('active');
};

Comments.removeForms = function() {
	$('#comments form button[type=reset]').click();
};

$(Comments.init);