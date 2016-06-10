var estadoSldr = 1;
var cantSlds = 3;
var ancho, alto, altoPant, anchoCont;
var fDelay;
var estadoMenu = false;
var estadoIng = false;

px = function(numSinPx){
	return numSinPx+"px";
}
cl = function(txt){
	console.log(txt);
}
dameDimensiones = function(){
    ancho = $(window).width();
    alto = $(window).height();
    
    if(ancho > 960){
	    anchoCont = 960;
    }else{
	    anchoCont = ancho;
    }
}
sldrCtrl = function(direccion){
	clearTimeout(fDelay);
	/*$("#s3_timerCount").remove();*/
	switch(direccion){
		case "P":
			if(estadoSldr > 1){
				$(".s2_sld-slI").each(function(index){
					$(this).animate({left: "+="+"100%"}, 500, function(){});
				})
				estadoSldr--;
			}
		break;
		case "N":
			if(estadoSldr < cantSlds){
				$(".s2_sld-slI").each(function(index){
					$(this).animate({left: "-="+"100%"}, 500, function(){});
				})
				estadoSldr++;
			}
		break;
	}
	playAutoSlide();
}
playAutoSlide = function(){
	/*$("#s3_timerCount").remove();
	$("#s3_timer").append('<div id="s3_timerCount"></div>');
	$("#s3_timerCount").css({
		width: "0%"
	});
	
	$("#s3_timerCount").animate({width: "100%"}, 5000, function(){});*/
	fDelay = setTimeout(function(){ 
		if(estadoSldr < cantSlds){
			$(".s2_sld-slI").each(function(index){
				$(this).animate({left: "-="+"100%"}, 500, function(){});
			})
			estadoSldr++;
		}else{
			$(".s2_sld-slI").each(function(index){
				$(this).animate({left: (index*100)+"%"}, 500, function(){});
			})
			estadoSldr=1;
		}
		/*$("#p1_timer").remove();*/
		playAutoSlide();
	},5000);/**/
}
redimensionar = function(){
	dameDimensiones();
	clearTimeout(fDelay);
	/*$("#s3_timerCount").remove();*/
	playAutoSlide();
	cl(ancho);
}
inicio = function(){
	redimensionar();
}

dameInicio = function(){
	window.location.replace("index.php");
}
accionMenu = function(){
	if(estadoMenu == false){
		$("#s1_btRD-c_menu").css({ display: "inherit" });
		estadoMenu = true;
	}else{
		$("#s1_btRD-c_menu").css({ display: "none" });
		estadoMenu = false;
	}
}
verCV = function(){
	$(".s0_popUp").addClass("dispInh");
}
ocultarCV = function(){
	$(".s0_popUp").removeClass("dispInh");
}

damePlusFch = function(id){
	$(".s3_des-fchro-fch-cont-pls").css({
		display: "none"
	});
	if($(".s3_des-fchro-fch-cont-btn-info"+id).html() != "VOLVER"){	
		$(".s3_des-fchro-fch"+id).children(".s3_des-fchro-fch-cont").children(".s3_des-fchro-fch-cont-pls").css({
			display: "inherit"
		});
		$(".s3_des-fchro-fch-cont-btn-info").html("MÁS INFO");
		$(".s3_des-fchro-fch-cont-btn-info"+id).html("VOLVER");	
	}else{
		$(".s3_des-fchro-fch-cont-pls").css({
			display: "none"
		});
		$(".s3_des-fchro-fch-cont-btn-info").html("MÁS INFO");
	}
}
dameMscPic = function(item){
	$(".s0_popUp").addClass("dispInh");
	$(".s0_popUp-boxPic-pic").html('<img src="'+item+'" />');
	$(".s0_popUp-boxPic-epi").html('Curabitur blandit tempus porttitor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et');
}
cerrarMscPic = function(){
	$(".s0_popUp").removeClass("dispInh");
}
accionIngreso = function(){
	if(estadoIng == false){
		$("#s1_bt-c_bsp-aul").parent().animate({top: "-="+"50px", opacity: 0}, 500, function(){});
		$("#s1_bt-c_bsp-ing").parent().animate({left: "-="+"200px"}, 500, function(){});
		$("#s1_bt-c_bsp-reg").parent().animate({top: "-="+"50px", opacity: 0}, 300, function(){});
		$("#s1_btRD-c_menu-ing-form").css({ display: "inherit" });
		estadoIng = true;
	}else{
		$("#s1_bt-c_bsp-aul").parent().animate({top: "+="+"50px", opacity: 1}, 500, function(){});
		$("#s1_bt-c_bsp-ing").parent().animate({left: "+="+"200px"}, 500, function(){});
		$("#s1_bt-c_bsp-reg").parent().animate({top: "+="+"50px", opacity: 1}, 300, function(){});
		$("#s1_btRD-c_menu-ing-form").css({ display: "none" });
		estadoIng = false;
	}
}

exp_mInc = function(){
	$(".s3_des-msg-mInc-form").addClass("activo");
	$(".s3_des-msg-mInc-form textarea").addClass("activo");
}
cont_mInc = function(){
	$(".s3_des-msg-mInc-form").removeClass("activo");
	$(".s3_des-msg-mInc-form textarea").removeClass("activo");
}

mostrarMsg = function(id){
	$(".s3_des-msg").css({ display: "none" });
	$(".s3_des-fchro-fch"+id+" .s3_des-msg").css({
		display: "inherit"
	})
}
ocultarMsg = function(){
	$(".s3_des-msg").css({ display: "none" });
}

$(window).scroll(function () {
    /*scrollP = $(window).scrollTop();
    if(scrollP > 32 && !$("#s2").hasClass("s2_fixed")){
	    $("body").addClass("bodyPadding");
		$("#s1").addClass("s1_display");
	    $("#s2").addClass("s2_fixed");
    }else if(scrollP < 32 && $("#s2").hasClass("s2_fixed")){
	    $("body").removeClass();
	    $("#s1").removeClass();
	    $("#s2").removeClass();
    }*/
});
$(window).on("resize", redimensionar);
$("body").ready(inicio);