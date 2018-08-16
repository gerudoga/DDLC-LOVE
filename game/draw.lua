lg = love.graphics
local drawbottom
local xps = {}
local yps = {}

function drawTopScreen()
	if drawbottom == 1 then
		lg.pop()
		drawbottom = 0
	elseif global_os == 'Horizon' then
		lg.setScreen('top')
	end
end

function drawBottomScreen()
	if global_os ~= 'Horizon' then
		lg.push()
		lg.translate((400 - 320) / 2, 240)
		drawbottom = 1
	else
		lg.setScreen('bottom')
	end
end

function dripText(text,charactersPerSecond,startTime)
	currentTime = love.timer.getTime()
	if (currentTime <= startTime) or startTime == 0 then return '' end
	if currentTime > startTime then myTextStartTime2 = love.timer.getTime() end
	if charactersPerSecond == nil then charactersPerSecond = 100 end
	return text:sub(1,math.min(math.floor((currentTime-startTime)*charactersPerSecond),text:len()))
end

function easeQuadOut(t,b,c,d)
	t = t / d
	return -(c) * t*(t-2) + b
end

function fadeOut(x)
	alpha = math.max(alpha - 3, 0)
	--fade out to poemgame
	if x == 1 then
		if alpha == 0 then
			changeState('poemgame')
		end
	--fade out from poemgame to game
	elseif x == 2 then
		if alpha == 0 then
			changeState('game',3)
		end
	--fade out from game to game (add 1 to chapter)
	elseif x == 3 then
		if alpha == 0 then
			chapter = chapter + 1
			changeState('game',3)
		end
	--fade out then go to next 2 lines
	elseif x == 4 then
		if alpha == 0 then
			scriptJump(cl + 2)
			alpha = 255
		end
	end
end

function cgHide()
	cg1 = ''
	cgch = nil
end

function drawdatetime()
	lg.print(os.date("%Y-%m-%d %H:%M"),205,220)
end

function drawTextBox()
	if settings.textloc == 'Top' then
		xps = {c=48,ct=63,textbox=40,namebox=52}
		yps = {c={166,182,198,214},ct=142,textbox=162,namebox=142}
		drawTopScreen()
	else
		xps = {c=8,ct=23,textbox=0,namebox=12}
		yps = {c={66,82,98,114},ct=42,textbox=62,namebox=42}
	end
	
	if style_edited then lg.setFont(deffont) end
	
	if (menu_enabled ~= true and poem_enabled ~= true) or (event_enabled and textbox_enabled) then
		lg.setColor(255,255,255,alpha)
		if ct ~= '' then lg.draw(namebox, xps.namebox, yps.namebox) end
		lg.draw(textbox, xps.textbox, yps.textbox)
		lg.setColor(0,0,0,alpha)
		lg.print(ct,xps.ct,yps.ct)
		if c_disp then
			for i = 1, 4 do
				lg.print(c_disp[i],xps.c,yps.c[i])
			end
		end
	end
	if settings.textloc == 'Top' then drawBottomScreen() end
end

function drawPoem()
	if poembg then
		lg.draw(poembg, 40, 0)
	else
		lg.setColor(243,243,243)
		lg.rectangle('fill',40,0,320,240)
	end
	lg.setColor(0,0,0)
	lg.print(poemtext, 45, 6)
end

function drawNumbers()
	if bgimg_disabled then 
		lg.setColor(255,255,255,255)
	else
		lg.setColor(0,0,0,255)
	end
	lg.print(cl,2,2)
end

function drawConsole()
	if console_enabled and console_font then
		lg.setColor(51,51,51,191)
		lg.rectangle('fill',0,0,320,60)
		lg.setColor(255,255,255)
		lg.setFont(console_font)
		lg.print('> '..console_text1,0,0)
		lg.print(console_text2,5,15)
		lg.print(console_text3,5,30)
	end
end

function updateSayori(a,b,px,py)
	if b == nil then b = '' end
	s_Set.a = a
	s_Set.b = b
	if xaload == 0 then loadSayori() end
	if px and autoskip < 1 and xaload > 0 and settings.animh == 1 then
		if s_Set.x < px then
			s_Set.x = math.min(s_Set.x + 24, px)
		elseif s_Set.x > px then
			s_Set.x = math.max(s_Set.x - 24, px)
		end
	elseif px and xaload > 0 then
		s_Set.x = px
	end
	if py ~= nil then s_Set.y = py end
end

function updateYuri(a,b,px,py)
	if b == nil then b = '' end
	y_Set.a = a 
	y_Set.b = b
	if xaload == 0 then loadYuri() end
	if px and autoskip < 1 and xaload > 0 and settings.animh == 1 then
		if y_Set.x < px then
			y_Set.x = math.min(y_Set.x + 24, px)
		elseif y_Set.x > px then
			y_Set.x = math.max(y_Set.x - 24, px)
		end
	elseif px and xaload > 0 then
		y_Set.x = px
	end
	if py ~= nil then y_Set.y = py end
end

function updateNatsuki(a,b,px,py)
	if b == nil then b = '' end
	n_Set.a = a
	n_Set.b = b
	if xaload == 0 then loadNatsuki() end
	if px and autoskip < 1 and xaload > 0 and settings.animh == 1 then
		if n_Set.x < px then
			n_Set.x = math.min(n_Set.x + 24, px)
		elseif n_Set.x > px then
			n_Set.x = math.max(n_Set.x - 24, px)
		end
	elseif px and xaload > 0 then
		n_Set.x = px
	end
	if py ~= nil then n_Set.y = py end
end

function updateMonika(a,b,px,py)
	if b == nil then b = '' end
	m_Set.a = a
	m_Set.b = b
	if xaload == 0 then loadMonika() end
	if px and autoskip < 1 and xaload > 0 and settings.animh == 1 then
		if m_Set.x < px then
			m_Set.x = math.min(m_Set.x + 24, px)
		elseif m_Set.x > px then
			m_Set.x = math.max(m_Set.x - 24, px)
		end
	elseif px and xaload > 0 then
		m_Set.x = px
	end
	if py ~= nil then m_Set.y = py end
end

function hideSayori()
	if s_Set.x <= -200 or autoskip > 0 or settings.animh == 0 then
		s_Set = {a='',b='',x=-200,y=0}
		if sl then unloadSayori() end
	elseif xaload > 0 then
		s_Set.x = math.max(s_Set.x - 24, -200)
	end
end

function hideYuri()
	if y_Set.x <= -200 or autoskip > 0 or settings.animh == 0 then
		y_Set = {a='',b='',x=-200,y=0}
		if yl then unloadYuri() end
	elseif xaload > 0 then
		y_Set.x = math.max(y_Set.x - 24, -200)
	end
end

function hideNatsuki()
	if n_Set.x <= -200 or autoskip > 0 or settings.animh == 0 then
		n_Set = {a='',b='',x=-200,y=0}
		if nl then unloadNatsuki() end
	elseif xaload > 0 then
		n_Set.x = math.max(n_Set.x - 24, -200)
	end
end

function hideMonika()
	if m_Set.x <= -200 or autoskip > 0 or settings.animh == 0 then
		m_Set = {a='',b='',x=-200,y=0}
		if ml then unloadMonika() end
	elseif xaload > 0 then
		m_Set.x = math.max(m_Set.x - 24, -200)
	end
end

function hideAll()
	s_Set = {a='',b='',x=-200,y=0}
	y_Set = {a='',b='',x=-200,y=0}
	n_Set = {a='',b='',x=-200,y=0}
	m_Set = {a='',b='',x=-200,y=0}
	unloadAll()
end

function drawSayori(a,b)
	if a=='1' or a=='1b' or a=='2' or a=='2b' or a=='3' or a=='3b' or a=='4' or a=='4b' then
		if sl then lg.draw(sl, s_Set.x, s_Set.y) end
		if sr then lg.draw(sr, s_Set.x, s_Set.y) end
	elseif a~='' then
		if sl then lg.draw(sl, s_Set.x, s_Set.y) end
	end
	
	if b~='' then
		if s_a then lg.draw(s_a, s_Set.x, s_Set.y) end
	end
end

function drawYuri(a,b)
	if a=='1' or a=='1b' or a=='2' or a=='2b' or a=='3' or a=='3b' then
		if yl then lg.draw(yl, y_Set.x, y_Set.y) end
		if yr then lg.draw(yr, y_Set.x, y_Set.y) end
	elseif a~='' then
		if yl then lg.draw(yl, y_Set.x, y_Set.y) end
	end

	if b~='' then
		if y_a then lg.draw(y_a, y_Set.x, y_Set.y) end
	end
end

function drawNatsuki(a,b)
	if a=='5' or a=='5b' then --set natsuki's head x and y pos
		nxh = n_Set.x + 4
		nyh = n_Set.y + 6
	else
		nxh = n_Set.x
		nyh = n_Set.y
	end

	if b~='' then
		if n_a then lg.draw(n_a, nxh, nyh) end
	end
	
	if a=='1' or a=='1b' or a=='2' or a=='2b' or a=='3' or a=='3b' or a=='4' or a=='4b' then
		if nl then lg.draw(nl, n_Set.x, n_Set.y) end
		if nr then lg.draw(nr, n_Set.x, n_Set.y) end
	elseif a~='' then
		if nl then lg.draw(nl, n_Set.x, n_Set.y) end
	end
end

function drawMonika(a,b)
	if a=='1' or a=='2' or a=='3' or a=='4' then
		if ml then lg.draw(ml, m_Set.x, m_Set.y) end
		if mr then lg.draw(mr, m_Set.x, m_Set.y) end
	elseif a~='' then
		if ml then lg.draw(ml, m_Set.x, m_Set.y) end
	end
	
	if b~='' then
		if m_a then lg.draw(m_a, m_Set.x, m_Set.y) end
	end
end