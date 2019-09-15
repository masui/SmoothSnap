//
// SmoothSnapで時刻設定
//
var hour = 0, min = 0, sec = 0;
var newhour = 0, newmin = 0, newsec = 0;

var video = $('#video').get(0);
video.currentTime = 0;
var playing = false;

getPlayTime = () => {
  if(! clicked && playing){
    t = Math.floor(video.currentTime);
    hour = newhour = Math.floor(t / 60);
    min = newmin = t % 60;
    sec = newsec = 0;
    showtime(hour,min,sec);
    settable(newhour,newmin,newsec);
  }
}

setInterval(getPlayTime, 1000);

pos =  (hour,min,sec) => {
    return (hour * 3600 + min * 60 + sec) / 4 / 80;
}

showtime = (h,m,s) => {
    // 時刻表示
    //$('#time').css('top',00);
    //$('#time').css('left',10);
    $('#hour').text(h);
    $('#min').text(('0'+m).slice(-2)); // 0詰め
    $('#sec').text(('0'+s).slice(-2));
    //$('#time').css('left',pos(h,m,s)-25);
}

display = (h,m,s) => {
    // 時刻表示
    //$('#time').css('top',00);
    //$('#time').css('left',10);
    $('#hour').text(h);
    $('#min').text(('0'+m).slice(-2)); // 0詰め
    $('#sec').text(('0'+s).slice(-2));

    //$('#time').css('left',pos(h,m,s)-25);

    $('#tab').css('left',pos(h,m,s) * 3);
    $('#tab').css('top',-10);

    var t = h * 60 + m + s / 60.0;
    if(t >= 1440) t = 1440;
    video.currentTime = t;
    // showtime hour,min,sec
}

mouseposx = (e) => {
  return e.pageX ? e.pageX : event.touches[0].pageX;
}

mouseposy = (e) => {
  return e.pageY ? e.pageY : event.touches[0].pageY;
}

var mousedownx = 0;
var mousedowny = 0;
var mousex = 0;
var mousey = 0;
var clicked = false;
var mintable = [];
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
        $('#dial').attr('src',`dial${mousex % 3 + 1}.png`);

    }
    return false;
}

mouseup = (event) => {
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

    $('#stop').on('mousedown', () => {
	playing = false;
	$('#stop').css('visibility', 'hidden');
	$('#play').css('visibility', 'visible');
	video.pause();
    });
    $('#play').on('mousedown', () => {
	playing = true;
	$('#stop').css('visibility', 'visible');
	$('#play').css('visibility', 'hidden');
	video.play();
    });

    display(hour,min,sec);
});
