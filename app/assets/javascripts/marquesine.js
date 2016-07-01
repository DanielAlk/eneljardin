var Marquesine = {};

Marquesine.load = function() {
	$.fn.marquesine = Marquesine.extension;
};

Marquesine.extension = function() {
	$(this).each(Marquesine.plugin);
};

Marquesine.plugin = function() {
	var marquesine = this;
	var $marquesine = $(marquesine);
	var dif, timer, position, started, resizeTimer;
	var init = function() {
		dif = marquesine.scrollWidth - marquesine.offsetWidth;
		if (dif) start();
		else stop();
	};
	var start = function() {
		started = true;
		left();
	};
	var stop = function() {
		clearTimeout(timer);
		position = null;
		timer = null;
		dif = null;
		started = null;
		$marquesine.css('text-indent', 0);
	};
	var left = function() {
		position = 'left';
		$marquesine.css('text-indent', dif*-1);
	};
	var right = function() {
		position = 'right';
		$marquesine.css('text-indent', 0);
	};
	var transitionend = function(e) {
		if (!started) return;
		timer = setTimeout(function() {
			if (position == 'left') right();
			else left();
		}, 600);
	};
	var resize = function() {
		if (started) stop();
		if (resizeTimer) clearTimeout(resizeTimer);
		resizeTimer = setTimeout(init, 1000);
	};
	$marquesine.on('transitionend', transitionend);
	$(window).on('resize', resize).load(init);
};

$(Marquesine.load);