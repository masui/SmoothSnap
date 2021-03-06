hour = 0
min = 0
sec = 0
newhour = 0
newmin = 0
newsec = 0
clicked = false
bgclicked = false
playing = false

video = $('#video').get(0)
# video.play()
video.currentTime = 0

getPlayTime = () ->
  if ! clicked && playing
    t = Math.floor(video.currentTime)
    hour = newhour = Math.floor(t / 60)
    min = newmin = t % 60
    sec = newsec = 0
    showtime hour, min, sec
    settable(newhour,newmin,newsec)

setInterval getPlayTime, 1000
  
dummyEventHandler = (event) ->

settime = (hour,min,sec) ->
  t = hour * 60 + min + sec / 60.0
  t = 1440 if t >= 1440
  video.currentTime = t
  showtime hour,min,sec

showtime = (hour,min,sec) ->
  $('#hour').text hour
  $('#min').text ('0'+min).slice(-2)
  $('#sec').text ('0'+sec).slice(-2)

  totalsec = ((hour * 60 + min) * 60) + sec
  x = totalsec / 4 / 80
  $('#knob').css 'left', x + 13
  $('#time').css 'top', 46
  $('#time').css 'left', x + 2

$('#lr').css 'visibility', 'hidden'

mousedownx = 0
mousedowny = 0
mousex = 0
mousey = 0
timetable = []

getMouseX = (e) -> e.pageX
getMouseY = (e) -> e.pageY
  
settable = (hour,min,sec) ->
  ind = 0
  timetable = []
  timetable[ind] = [hour, min, sec]
  h = hour
  m = min
  s = sec
  ind--
  timetable[ind] = [h, m, s]
  for i in [0...10]
    if s > 0
      s -= 1
    else
      if m > 0
        m -= 1; s = 59
      else
        if h > 0
          h -= 1; m = 59; s = 59
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]

  [0...8].forEach (i) ->
    if s % 10 != 0
      s = s - s % 10
    else
      if s > 0
        s -= 10
      else
        if m > 0
           m -= 1; s = 50
        else
          if h > 0
            h -= 1; m = 59; s = 50
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]

  [0...10].forEach (i) ->
    if m > 0
      m -= 1; s = 0
    else
      if h > 0
        h -= 1; m = 59; s = 0
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]

  [0...8].forEach (i) ->
    if m % 10 != 0
      m = m - m % 10; s = 0
    else
      if m > 0
        m -= 10; s = 0
      else
        if h > 0
          h -= 1; m = 50; s = 0
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]

  while true
    if m % 60 != 0
      m = 0; s = 0
    else
      if h > 0
        h -= 1; m = 0; s = 0
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]
    timetable[--ind] = [h, m, s]
    break if h == 0
    brea if ind < -1000

  h = hour
  m = min
  s = sec
  ind = 0
  [0...10].forEach (i) ->
    if s < 59
      s += 1
    else
      if m < 59
        m += 1; s = 0
      else
        if h < 23
          h += 1; m = 0; s = 0
        else
          h = 24; m = 0; s = 0
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]

  [0...8].forEach (i) ->
    if s % 10 != 0
      s = s - s % 10
      if s == 50
        if m < 59
          m += 1; s = 0
      else
        s += 10
    else
      if s < 50
        s += 10
      else
        if m < 59
          m += 1; s = 0
        else
          if h < 23
            h += 1; m = 0; s = 0
          else
            h = 24; m = 0; s = 0
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]

  [0...10].forEach (i) ->
    if m < 59
      m += 1; s = 0
    else
      if h < 23
        h += 1; m = 0; s = 0
      else
        h = 24; m = 0; s = 0
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]

  [0...8].forEach (i) ->
    if m % 10 != 0
      m = m - m % 10
      if m == 50
        if h < 23
          h += 1; m = 0; s = 0
      else
        m += 10; s = 0
    else
      if m < 50
        m += 10; s = 0
      else
        if h < 23
          h += 1; m = 0; s = 0
        else
          h = 24; m = 0; s = 0
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]

  while true
    if m % 60 != 0
      if h < 23
        h += 1; m = 0; s = 0
      else
        m = 59; s = 59
    else
      if h < 23
        h += 1; m = 0; s = 0
      else
        h = 24; m = 0; s = 0
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]
    timetable[++ind] = [h, m, s]
    break if h == 24 && m == 0 && s == 0
    break if h == 23 && m == 59 && s == 59 
    break if ind > 1000

mousedownbg = (event) ->
  bgclicked = true

  $('#slider').css 'cursor','url("hideCursor.png"), pointer'
  $('body').css 'cursor','url("hideCursor.png"), pointer'

  mousedownx = getMouseX(event)
  mousedowny = getMouseY(event)
  mousex = mousedownx
  mousey = mousedowny

  if document.getElementById('knob').offsetLeft < mousex
    if ! (sec == 59 && min == 59 && hour == 23)
      sec = sec + 1
      if sec >= 60
        sec = 0
        min = min + 1
        if min >= 60
          min = 0
          hour = hour + 1
  else
    if sec > 0 || min > 0 || hour > 0
      sec = sec - 1
      if sec < 0
        sec = 59
        min = min - 1
        if min < 0
          min = 59
          hour = hour - 1


  newhour = hour
  newmin = min
  newsec = sec
  settime(newhour,newmin,newsec)
  settable(newhour,newmin,newsec)

  #$('#knob').css 'width', 30
  #$('#knob').css 'top', 24
  #$('#knob').attr 'src', 'memori.png'
  $('#lr').css 'visibility', 'visible'
  $('#lr').css 'top', 30
  $('#lr').css 'left', mousedownx - 10
  
  false

mousedownknob = (event) ->
  clicked = true
  mousedownx = getMouseX(event)
  mousedowny = getMouseX(event)
  mousex = mousedownx
  mousey = mousedowny
  offsetx = document.getElementById('slider').offsetLeft
  newhour = Math.floor((mousex-offsetx-10) / 12)
  if newhour < 0
    newhour = 0
  if newhour >= 24
    newhour = 23
  newmin = 0
  newsec = 0
  hour = newhour
  min = newmin
  sec = newsec
  settime(newhour,newmin,newsec)
  settable(newhour,newmin,newsec)
  $('#knob').css 'width', 20
  $('#knob').css 'top', 24
  $('#knob').attr 'src', 'knob.png'
  false

mousemove = (event) ->
  event.preventDefault()
  mousex = getMouseX(event)
  mousey = getMouseY(event)

  if clicked
    ind = mousex - mousedownx
    if ind != 0
      t = ((hour * 60 + min) * 60) + sec
      t += ind * 320
      # tは600の倍数にしたい?
      t = Math.floor((t + 300) / 600) * 600
      newsec = 0
      newhour = Math.floor(t / 3600)
      if t < 0
        newhour = 0
        newmin = 0
        newsec = 0
      else if newhour >= 24
        newhour = 24
        newmin = 0
        newsec = 0
      else
        newmin = Math.floor((t - newhour * 3600) / 60)
        newsec = 0
      settime newhour, newmin, newsec
  else    
    if bgclicked
      $('#slider').css 'cursor','url("hideCursor.png"), pointer'
      $('body').css 'cursor','url("hideCursor.png"), pointer'
      $('#knob').css 'width', 30
      $('#knob').css 'top', 24
      $('#knob').attr 'src', 'memori.png'
      $('#lr').css 'visibility', 'visible'
      $('#lr').css 'top', mousey - mousedowny + 30
      $('#lr').css 'left', mousex - 10

      ind = mousex - mousedownx
      if timetable[ind]
        settime(timetable[ind][0],timetable[ind][1],timetable[ind][2])
        [newhour, newmin, newsec] = timetable[ind]


  $('#lr').css 'top', mousey - mousedowny + 30
  $('#lr').css 'left', mousex - 10

mouseup = (event) ->
  false
  $('body').css 'cursor','' # カーソル復活
  $('#slider').css 'cursor','' # カーソル復活
  min = newmin
  sec = newsec
  hour = newhour
  clicked = false
  bgclicked = false
  $('#knob').css 'width', 20
  $('#knob').css 'top', 24
  $('#knob').attr 'src', 'knob.png'
  $('#lr').css 'visibility', 'hidden'
  false

$ ->
  settime 0, 0, 0
  $('body').on 'click', dummyEventHandler
  $('#knob').on 'mousedown', mousedownknob
  $('#knobbg').on 'mousedown', mousedownbg
  $(document).on 'mousemove', mousemove
  $(document).on 'mouseup', mouseup
  $('#slider').on 'mousedown', (event) ->
    event.preventDefault()
    mousedownbg(event)
  $('#stop').on 'mousedown', () ->
    playing = false
    $('#stop').css 'visibility', 'hidden'
    $('#play').css 'visibility', 'visible'
    video.pause()
  $('#play').on 'mousedown', () ->
    playing = true
    $('#stop').css 'visibility', 'visible'
    $('#play').css 'visibility', 'hidden'
    video.play()
