var hour = 12, min = 0, sec = 0;
var newhour, newmin, newsec;

var showstatus = false;

dummyEventHandler = (event) => {}

settime = (hour,min,sec) => {
    var s;
    $('#hour').text(hour);
    $('#min').text(('0'+min).slice(-2)); // 0詰め
    $('#sec').text(('0'+sec).slice(-2));
    
    let totalsec = hour * 3600 + min * 60 + sec;
    let x = totalsec / 4 / 80;
    $('#knob').css('left',x + 13);
<<<<<<< HEAD
    $('#cursor').css('top',$('#slider').css('offsetTop') + 20);
    $('#cursor').css('left',x + 13 + 10);
=======
    $('#cursor').css('top',$('#slider').css('offsetTop'));
    $('#cursor').css('left',x + 13);
>>>>>>> a4c24414b40711acdb43d330830b4e2e22cb180c
    
    $('#time').css('top',46);
    $('#time').css('left',x + 2);
}

var mousedownx = 0;
var mousedowny = 0;
var mousex = 0;
var mousey = 0;
var clicked = false;
var mintable = [];
var hourtable = [];
var sectable = [];

settable = (hour,min,sec) => {
    var ind = 0;
    var h, m, s;
    var count;
    hourtable = [];
    mintable = [];
    sectable = [];
    hourtable[ind] = hour;
    mintable[ind] = min;
    sectable[ind] = sec;
    [h, m, s] = [hour, min, sec];
    ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    for(i=0;i<10;i++){
	if(s > 0){ s -= 1; }
	else {
	    if(m > 0){ m -= 1; s = 59; }
	    else { if(h > 0){ h -= 1; m = 59; s = 59; }}
	}
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    }
    for(i=0;i<8;i++){
	if(s % 10 != 0){ s = s - s % 10; }
	else {
	    if(s > 0){ s -= 10; }
	    else {
		if(m > 0){ m -= 1; s = 50; }
		else { if(h > 0) h -= 1; m = 59; s = 50; }
	    }
	}
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    }
    for(i=0;i<10;i++){
	if(m > 0){ m -= 1; s = 0; } else { if(h > 0){ h -= 1; m = 59; s = 0;}}
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    }
    for(i=0;i<8;i++){
	if(m % 10 != 0){ m = m - m % 10; s = 0; }
	else {
	    if(m > 0){ m -= 10; s = 0; } else { if(h > 0){ h -= 1; m = 50; s = 0;}}
	}
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    }
    for(;;){
	if(m % 60 != 0){ m = 0; s = 0; }
	else {
	    if(h > 0){ h -= 1; m = 0; s = 0;}
	}
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind--; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	if(h == 0) break;
    }
    [h, m, s] = [hour, min, sec];
    ind = 0;
    for(i=0;i<10;i++){
	if(s < 59){ s += 1; }
	else {
	    if(m < 59){ m += 1; s = 0; }
	    else { if(h < 23){ h += 1; m = 0; s = 0; } else { h = 23; m = 59; s = 59; }}
	}
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    }
    for(i=0;i<8;i++){
	if(s % 10 != 0){
	    s = s - s % 10;
	    if(s == 50){
		if(m < 59){
		    m += 1; s = 0;
		}
	    }
	    else {
		s += 10;
	    }
	}
	else {
	    if(s < 50){ s += 10; }
	    else {
		if(m < 59){ m += 1; s = 0; }
		else { if(h < 23){ h += 1; m = 0; s = 0; } else { h = 23; m = 59; s = 59;}}
	    }
	}
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    }
    for(i=0;i<10;i++){
	if(m < 59){ m += 1; s = 0; }
	else { if(h < 23){ h += 1; m = 0; s = 0; } else {h = 23; m = 59; s = 59; }}
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    }
    for(i=0;i<8;i++){
	if(m % 10 != 0){
	    m = m - m % 10;
	    if(m == 50){
		if(h < 23){
		    h += 1; m = 0; s = 0;
		}
	    }
	    else {
		m += 10; s = 0;
	    }
	}
	else {
	    if(m < 50){ m += 10; s = 0; }
	    else { if(h < 23){ h += 1; m = 0; s = 0;} else { h = 23; m = 59; s = 59; }}
	}
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
    }
    for(;;){
	if(m % 60 != 0){
	    if(h < 23){
		h += 1; m = 0; s = 0;
	    }
	    else {
		m = 59; s = 59;
	    }
	}
	else {
	    if(h < 23){ h += 1; m = 0; s = 0;}
	    else { m = 59; s = 59;}
	}
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	ind++; hourtable[ind] = h; mintable[ind] = m; sectable[ind] = s;
	if(h == 23 && m == 59 && s == 59) break;
    }
}

mousedown = (event) => {
    if(showstatus){
	$('#knobbg').css('backgroundColor', '#ff8'); // ノブを動かしてるとき
	$('#mouseupdown').text("Mouse DOWN");
    }
    $('#slider').css('cursor','url("hideCursor.png"), pointer');
    $('body').css('cursor','url("hideCursor.png"), pointer');
    $('#cursor').css('display','block');
    $('#cursor').css('left','20');
    $('#cursor').css('top','20');

    clicked = true;
    mousedownx = event.pageX;
    mousedowny = event.pageY;
    mousex = mousedownx;
    mousey = mousedowny;
    newhour = hour;
    newmin = min;
    newsec = sec;
    settime(newhour,newmin,newsec);
    settable(newhour,newmin,newsec);
    return false;
}

mousedownbg = (event) => {
    if(showstatus){
	$('#knobbg').css('backgroundColor', '#ff8');
	$('#mouseupdown').text("Mouse DOWN");
    }
    $('#slider').css('cursor','url("hideCursor.png"), pointer');
    $('body').css('cursor','url("hideCursor.png"), pointer');
    $('#cursor').css('display','block');

    clicked = true;
    mousedownx = event.pageX;
    mousedowny = event.pageY;
    mousex = mousedownx;
    mousey = mousedowny;
    offsetx = document.getElementById('slider').offsetLeft;
    newhour = Math.floor((mousex-offsetx-10) / 12);
    if(newhour < 0) newhour = 0;
    if(newhour >= 24) newhour = 23;  
    newmin = 0;
    newsec = 0;
    settime(newhour,newmin,newsec);
    settable(newhour,newmin,newsec);
    return false;
}

mousemove = (event) => {
    event.preventDefault();
    if(clicked){
	mousedownx = event.pageX;
	mousedowny = event.pageY;
	ind = mousedownx - mousex;
	if(hourtable[ind] != null){
	    settime(hourtable[ind],mintable[ind],sectable[ind]);
	    newhour = hourtable[ind];
	    newmin = mintable[ind];
	    newsec = sectable[ind];
	}
    }
    return false;
}

mouseup = (event) => {
    if(showstatus){
	$('#knobbg').css('backgroundColor', '#fff');
	$('#mouseupdown').text("Mouse UP");
    }
    //$('body').css('cursor',''); // カーソル復活
    //$('#slider').css('cursor',''); // カーソル復活
    //$('#cursor').css('display','none'); // カーソル復活
    hour = newhour;
    min = newmin;
    sec = newsec;
    clicked = false;
    return false;
}

mouseleave = (event) => {
    // カーソル復活
    $('body').css('cursor','');
    $('#slider').css('cursor','');
    $('#cursor').css('display','none');
}

$(function(){
    $(document).on('mousemove', mousemove);
    $(document).on('mouseup', mouseup);
    
    $('#knob').on('mousedown', mousedown);
    $('#knobbg').on('mousedown', mousedownbg);

    $('#slider').on('mouseleave', mouseleave);
    
    settime(hour,min,sec);
    $('body').on('click', dummyEventHandler);
});

