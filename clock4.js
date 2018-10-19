//
// SmoothSnapで時刻設定
//
var hour = 12, min = 0, sec = 0;
var newhour = 12, newmin = 0, newsec = 0;

var showstatus = false;

dummyEventHandler = (event) => {}

pos =  (hour,min,sec) => {
    return (hour * 3600 + min * 60 + sec) / 4 / 80;


    // 時刻表示
    $('#hour').text(hour);
    $('#sec').text(('0'+s).slice(-2));
}

display = (h,m,s) => {
    $('#time').css('top',00);
    $('#time').css('left',10);
    $('#min').text(('0'+m).slice(-2)); // 0詰め
    $('#time').css('left',pos(h,m,s));

    $('#tab').css('left',pos(h,m,s)-30);
    $('#tab').css('top',-5);

    //pos1 = pos(hour,min,sec);
    //pos2 = pos(newhour,newmin,newsec);
    //if(pos2 < pos1){
    //    [pos1, pos2] = [pos2, pos1];
    //}
    //$('#knob').css('left',pos1);
    //width = pos2 - pos1;
    //if(width < 1) width = 1;
    //$('#knob').css('width',width);
    //$('#text1').text(pos1);
    // 

}

mouseposx = (e) => {
  return e.pageX ? e.pageX : event.touches[0].pageX;
}

mouseposy = (e) => {
  return e.pageY ? e.pageY : event.touches[0].pageY;
}

var mousedownx = 0;
var clicked = false;
var mousedowny = 0;
var mintable = [];
var mousex = 0;
var mousey = 0;
var hourtable = [];
var sectable = [];
var fakemousex, fakemousey;

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

    clicked = true;
    mousedownx = mouseposx(event);
    mousedowny = mouseposy(event);
    mousex = mousedownx;
    mousey = mousedowny;
    newhour = hour;
    newmin = min;
    newsec = sec;
    display(newhour,newmin,newsec);
    settable(newhour,newmin,newsec);
    return false;
}

mousemove = (event) => {
    event.preventDefault();
    if(clicked){
	mousex = mouseposx(event);
	mousey = mouseposy(event);
	ind = mousex - mousedownx;
	if(hourtable[ind] != null){
	    display(hourtable[ind],mintable[ind],sectable[ind]);
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
    hour = newhour;
    min = newmin;
    sec = newsec;
    clicked = false;
    display(hour,min,sec);
    return false;
}

$(function(){
    $(document).on('mousemove', mousemove);
    $(document).on('touchmove', mousemove);

    $(document).on('mouseup', mouseup);
    $(document).on('touchend', mouseup);
    
    $(document).on('mousedown', mousedown);
    $(document).on('touchstart', mousedown);

    display(hour,min,sec);

    $('body').on('click', dummyEventHandler);
});
