hour = 12
min = 0
sec = 0
newhour = 12
newmin = 0
newsec = 0
  
dummyEventHandler = (event) ->

settime = (hour,min,sec) ->
  $('#hour').text hour
  $('#min').text ('0'+min).slice(-2)
  $('#sec').text ('0'+sec).slice(-2)

  # $('#video')[0].currentTime = min * 1.0 + sec / 60.0
  
  totalsec = ((hour * 60 + min) * 60) + sec
  x = totalsec / 4 / 80
  $('#knob').css 'left', x + 13
  $('#time').css 'top', 46
  $('#time').css 'left', x + 2

mousedownx = 0
mousedowny = 0
mousex = 0
mousey = 0
clicked = false
bgclicked = false
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

mousedown = (event) ->
  clicked = true
  mousedownx = getMouseX(event)
  mousedowny = getMouseX(event)
  mousex = mousedownx
  mousey = mousedowny
  newhour = hour
  newmin = min
  newsec = sec
  settime(newhour,newmin,newsec)
  settable(newhour,newmin,newsec)
  false

mousedownbg = (event) ->
  bgclicked = true
  mousedownx = getMouseX(event)
  mousedowny = getMouseX(event)
  mousex = mousedownx
  mousey = mousedowny
  newhour = hour
  newmin = min
  newsec = sec
  settime(newhour,newmin,newsec)
  settable(newhour,newmin,newsec)
  false

mousedownbg_old = (event) ->
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
  settime(newhour,newmin,newsec)
  settable(newhour,newmin,newsec)
  false

mousemove = (event) ->
  event.preventDefault()
  mousedownx = getMouseX(event)
  mousedowny = getMouseX(event)

  if clicked
    ind = mousedownx - mousex
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
    
  if bgclicked
    ind = mousedownx - mousex
    if timetable[ind]
      settime(timetable[ind][0],timetable[ind][1],timetable[ind][2])
      [newhour, newmin, newsec] = timetable[ind]
  false

mouseup = (event) ->
  hour = newhour
  min = newmin
  sec = newsec
  clicked = false
  bgclicked = false
  false

$ ->
  settime 12, 0, 0
  $('body').on 'click', dummyEventHandler
  $('#knob').on 'mousedown', mousedown
  $('#knobbg').on 'mousedown', mousedownbg
  $('#slider').on 'mousedown', (event) ->
    event.preventDefault()
    mousedownbg(event)
  $(document).on 'mousemove', mousemove
  $(document).on 'mouseup', mouseup
