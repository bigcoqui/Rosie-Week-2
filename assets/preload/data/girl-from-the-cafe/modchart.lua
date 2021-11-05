--my collection lol
--thx Camellia mod, weegee mod, oh **** a shark mod, dark sheep mod, roses modchart mod, techno mod, and the person who made the modchart engine mod.
local kindamove = false
local resetti = false
local slowswayer = false
local spin1 = false
local spin2 = false
local spincenter = false
local normal1 = false
local normal2 = false
local swayGO = false 
local swayGOMessy = false 
local originalCamHudAngle

local hudrotate = false
local hudrotatecalm = false
local shook = false
local swayingsmall = false
local swayingvert = false
local swayingreturn = false
local swayinglarge = false
local swayingbigger = false
local swayingbiggest = false
local swayingbiggest2 = false
local swaySlowP1 = false 
local swaySlowP2 = false 
local swayScreenP2 = false
local swayScreenLargerP2 = false
local swaySlow = false 
local swayFastP1 = false 
local swayFast = false 
local swayIntense = false 
local swayIntense2 = false 
local swayIntense3 = false 
local swayIntense4 = false
local glitch = false 
local glitchier = false 
local shifted = false 
local glitched = false 

local fading = false 
local faded = false 
local fadingFast = false 
local fadedFast = false 
local fadingFaster = false 
local fadedFaster = false 

local partySideways = false 
local partiedSideways = false 
local partyIDiagonal = false 
local partyODiagonal = false 
local partiedIDiagonal = false 
local partiedODiagonal = false 
local partyRoundLeft = false 
local partyRoundRight = false 
local partyWave = false 

local partySideways2 = false 
local partiedSideways2 = false 
local partyIDiagonal2 = false 
local partyODiagonal2 = false 
local partiedIDiagonal2 = false 
local partiedODiagonal2 = false 

local waitForBeatMove = false
local waitForBeatFade = false
local waitForStepMove = false 
local waitForStepFade = false 

local swaySlowAlt = false 
local swayIntenseAlt = false 
local swayIntense2Alt = false 

local swayScreenP1Alt = false 

local background = nil

local hudX = 0
local hudY = 0

local fourStartX = 0
local fiveStartX = 0
local sixStartX = 0
local sevenStartX = 0

local hudZoom = 0

local spinCrazy = false
local spin = false
local spinUpFast = false

local hit = false
local directionMulti = 1
local heightMulti = 1

local direction = 2

local l1 = false
local l1c = false
local l2 = false
local l3 = false
local b1 = false
local b2 = false
local ex1 = false
local l11 = false
local swaybg = false
local swayingForce = 1;
local wbfb = false
local waitForTween = false
local move = false

local swaying1 = false
local swaying2 = false
local swaying3 = false
local swaying4 = false
local swayingup1 = false
local swayingup2 = false
local swayingup3 = false
local swayingup4 = false
local swayingbiggest = false
local swayingbiggest2 = false
local swayingdown = false -- No Used

local gl = false
local sl = false
local bign = false
local lol = false

local noteleftright = false
local manicnotes = false
local swing3 = false
local zoa1 = false
local l = false
local ll = false
local swayingForce = 1;

local mk1 = false

local swing1 = false
local swing2 = false

function start (song)
	hudX = getHudX()
    hudY = getHudY()
	useDownscroll(false)
	spinLength = 0

	WhiteBG = makeSprite('WhiteBG','whitebg', true)
	BlackBG = makeSprite('BlackFade','blackbg', true)
	WhiteFade = makeSprite('WhiteBG','whitefade', false)
	BlackFade = makeSprite('BlackFade','blackfade', false)

	setActorX(200,'whitebg')
	setActorY(500,'whitebg')
	setActorAlpha(0,'whitebg')
	setActorScale(4,'whitebg')
	
	setActorX(200,'blackbg')
	setActorY(500,'blackbg')
	setActorAlpha(1,'blackbg')
	setActorScale(4,'blackbg')
	
	setActorX(200,'blackfade')
	setActorY(500,'blackfade')
	setActorAlpha(0,'blackfade')
	setActorScale(4,'blackfade')
	
	setActorX(200,'whitefade')
	setActorY(500,'whitefade')
	setActorAlpha(0,'whitefade')
	setActorScale(4,'whitefade')

	setActorAlpha(0,'boyfriend')
	setActorAlpha(0,'dad')
	setActorAlpha(0,'girlfriend')

	hide = false
	showOnlyStrums = true
	
	setHudPosition(0, 1000)
end

function resetTween()
	waitForTween = false
end

function update (elapsed)
	local currentBeat = (songPos / 1000)*(bpm/60)
	local currentBeatWave = (songPos / 1000)*(bpm/60)
	if swayGO then 
        for i = 4, 7 do 
            setActorX(_G['defaultStrum'..i..'X'] - 32 * math.sin((currentBeat + i*0)), i)
            setActorY(_G['defaultStrum'..i..'Y'] - 64 * math.cos((currentBeat + i*32) * math.pi),i)
        end 
    end
    if swayGOMessy then 
        for i = 4, 7 do 
            setActorX(_G['defaultStrum'..i..'X'] - 32 * math.sin((currentBeat + i*5)), i)
            setActorY(_G['defaultStrum'..i..'Y'] - 64 * math.cos((currentBeat + i*32) * math.pi),i)
        end 
    end
	if strumcircle then 
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
    end
	if strumcircle then 
        camHudAngle = 4 * math.sin(currentBeatWave * math.pi) --Code stolen from DarkSheep lmao (please don't kill me KadeDev)
    end
	if strumcirclereset then 
        camHudAngle = originalCamHudAngle
    end
	if mk1 then
        for i=0,7 do
            setActorX(_G['defaultStrum'..i..'X'] + 24 * math.sin((currentBeat + i*0.05) * math.pi), i)
            setActorY(_G['defaultStrum'..i..'Y'] + 8 * math.cos((currentBeat + i*0.10) * math.pi), i)
        end
    end
	if noteleftright then
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 105 * math.sin((currentBeat + i*0.38)), i)
		end
	end
    if swayingvert then
        for i=0,7 do
            setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*0.33) * math.pi) ,i)
        end
    end
    if manicnotes then -- not used
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 65 * math.sin((currentBeat + i*0.30) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 60 * math.cos((currentBeat + i*0.24) * math.pi), i)
		end
	end
    if zoa1 then
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 100 * math.sin((currentBeat + i*0)), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 50 * math.cos((currentBeat + i*0.30) * math.pi), i)
		end
    end
    if bign then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 36 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 74 * math.cos((currentBeat + i*0.08) * math.pi), i)
		end
	end
    if lol then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 14 * math.sin((currentBeat + i*0.10) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0) * math.pi), i)
		end
	end
	if swayingdown then -- No Used
        for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 16 * math.sin((currentBeat + i*0.8) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] - 20 * math.cos((currentBeat + i*0.12) * math.pi) ,i)
		end
	end
	if swayingbiggest3 then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] + 320 * math.sin((currentBeat + i*0)) + 350, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 70 * math.cos((currentBeat + i*5.45) * math.pi),i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 320 * math.sin((currentBeat + i*0)) - 275, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 79 * math.cos((currentBeat + i*5.45) * math.pi),i)
		end
	end
	if spinCrazy then -- spinning crazy
        camHudAngle = 32 * math.sin(currentBeat * math.pi)
        if getHudX() < 320 then
            setHudPosition(getHudX() + 4, 32 * math.cos(currentBeat * math.pi))
        else
            setHudPosition(-640, 32 * math.cos(currentBeat * math.pi))
        end
    end
	if spin then
        if getHudX() + 640 > 1280 and not hit then
            hit = not hit
            direction = 2 * directionMulti
        elseif hit then
            if getHudX() - 640 > -1280 and hit then
                direction = -2 * directionMulti
            else
                hit = not hit
                direction = 2 * directionMulti
            end
        end
        setHudPosition(getHudX() + direction, 32 * math.cos(currentBeat * math.pi) * heightMulti)
    end
	if glitch then 
        if curBeat % 4 == 0 then 
            shifted = not shifted
            if shifted then 
                for i = 0, 7 do 
                    setActorX(_G['defaultStrum'..i..'X'] + 40 * math.sin((currentBeat + i*0)), i)
                end
            else
                for i = 0, 7 do 
                    setActorX(_G['defaultStrum'..i..'X'] - 40 * math.sin((currentBeat + i*0)), i)
                end
            end
        end
    end
    if glitchier then 
        if curBeat % 2 == 0 then 
            shifted = not shifted
            if shifted then 
                for i = 0, 7 do 
                    setActorX(_G['defaultStrum'..i..'X'] + 40 * math.sin((currentBeat + i*0)), i)
                end
                glitched = not glitched
                if glitched then 
                    for i = 0, 7 do 
                        setActorY(_G['defaultStrum'..i..'Y'] + 10 * math.sin((currentBeat + i*0)), i)
                    end
                else 
                    for i = 0, 7 do 
                        setActorY(_G['defaultStrum'..i..'Y'] - 10 * math.sin((currentBeat + i*0)), i)
                    end
                end
            else
                for i = 0, 7 do 
                    setActorX(_G['defaultStrum'..i..'X'] - 40 * math.sin((currentBeat + i*0)), i)
                end
            end
        end
    end
    if fading then 
        if curBeat % 16 == 0 and not waitForBeatFade then 
            waitForBeatFade = true
            faded = not faded 
            if faded then 
                for i = 0, 7 do 
                    tweenFadeIn(i, 0.1, 4.35)
                end
            else 
                for i = 0, 7 do 
                    tweenFadeOut(i, 1, 4.35)
                end
            end
        end
    end
    if partySideways then 
        for i = 0, 7 do 
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 40, getActorAngle(i), 0.25, i)
        end
    end
    if partySidewaysReset then
        for i = 0, 7 do 
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 40, getActorAngle(i), 0.25, i)
        end
    end
    if partyIDiagonal then 
        if curBeat % 1 == 0 and not waitForBeatMove then 
            waitForBeatMove = true
            partiedIDiagonal = not partiedIDiagonal
            if partiedIDiagonal then 
                for i = 4, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 40, getActorAngle(i), 0.25, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] - 40, getActorAngle(i), 0.25, i)
                end
                for i = 0, 3 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 40, getActorAngle(i), 0.25, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] - 40, getActorAngle(i), 0.25, i)
                end
            else 
                for i = 4, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 40, getActorAngle(i), 0.25, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] + 40, getActorAngle(i), 0.25, i)
                end
                for i = 0, 3 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 40, getActorAngle(i), 0.25, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] + 40, getActorAngle(i), 0.25, i)
                end
            end
        end
    end
    if partyODiagonal then 
        if curBeat % 1 == 0 and not waitForBeatMove then 
            waitForBeatMove = true
            partiedODiagonal = not partiedODiagonal
            if partiedODiagonal then 
                for i = 4, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 40, getActorAngle(i), 0.25, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] - 40, getActorAngle(i), 0.25, i)
                end
                for i = 0, 3 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 40, getActorAngle(i), 0.25, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] - 40, getActorAngle(i), 0.25, i)
                end
            else 
                for i = 4, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 40, getActorAngle(i), 0.25, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] + 40, getActorAngle(i), 0.25, i)
                end
                for i = 0, 3 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 40, getActorAngle(i), 0.25, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] + 40, getActorAngle(i), 0.25, i)
                end
            end
        end
    end
    if partySideways2 then 
        if curStep % 2 == 0 and not waitForStepMove then 
            waitForStepMove = true
            partiedSideways2 = not partiedSideways2
            if partiedSideways2 then 
                for i = 0, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 40, getActorAngle(i), 0.1, i)
                end
            else 
                for i = 0, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 40, getActorAngle(i), 0.1, i)
                end
            end
        end
    end
    if partyIDiagonal2 then 
        if curStep % 2 == 0 and not waitForStepMove then 
            waitForStepMove = true
            partiedIDiagonal2 = not partiedIDiagonal2
            if partiedIDiagonal2 then 
                for i = 4, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 40, getActorAngle(i), 0.1, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] - 40, getActorAngle(i), 0.1, i)
                end
                for i = 0, 3 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 40, getActorAngle(i), 0.1, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] - 40, getActorAngle(i), 0.1, i)
                end
            else 
                for i = 4, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i), 0.1, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], getActorAngle(i), 0.1, i)
                end
                for i = 0, 3 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i), 0.1, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], getActorAngle(i), 0.1, i)
                end
            end
        end
    end
    if partyODiagonal2 then 
        if curStep % 2 == 0 and not waitForStepMove then 
            waitForStepMove = true
            partiedODiagonal2 = not partiedODiagonal2
            if partiedODiagonal2 then 
                for i = 4, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 40, getActorAngle(i), 0.1, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] - 40, getActorAngle(i), 0.1, i)
                end
                for i = 0, 3 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 40, getActorAngle(i), 0.1, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'] - 40, getActorAngle(i), 0.1, i)
                end
            else 
                for i = 4, 7 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i), 0.1, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], getActorAngle(i), 0.1, i)
                end
                for i = 0, 3 do 
                    tweenPosXAngle(i, _G['defaultStrum'..i..'X'], getActorAngle(i), 0.1, i)
                    tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], getActorAngle(i), 0.1, i)
                end
            end
        end
    end
    if partyRoundLeft then 
        for i = 0, 7 do 
			setActorX(_G['defaultStrum'..i..'X'] - 80 * math.sin((currentBeat + i*0) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*4) * math.pi),i)
        end 
    end
    if partyRoundRight then 
        for i = 0, 7 do 
			setActorX(_G['defaultStrum'..i..'X'] + 20 * math.sin((currentBeat + i*0) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*4) * math.pi),i)
        end 
    end
    if partyWave then 
        for i = 0, 3 do 
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*128)),i)
        end 
        for i = 4, 7 do 
			setActorX(_G['defaultStrum'..i..'X'] - 64 * math.sin((currentBeat + i*0) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*128)),i)
        end 
    end
	
	if swaySlowP1 then 
        for i = 0, 3 do 
            setActorX(_G['defaultStrum'..i..'X'] - 32 * math.sin((currentBeat + i*0)) + 16, i)
            setActorY(_G['defaultStrum'..i..'Y'],i)
        end 
    end
    if swaySlowP2 then 
        for i = 4, 7 do 
            setActorX(_G['defaultStrum'..i..'X'] - 32 * math.sin((currentBeat + i*0)) + 16, i)
            setActorY(_G['defaultStrum'..i..'Y'],i)
        end 
    end
    if swaySlow then 
        for i = 0, 7 do 
            setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0)), i)
            setActorY(_G['defaultStrum'..i..'Y'],i)
        end 
    end
    if swayFast then 
        for i = 0, 7 do 
            setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0)), i)
            setActorY(_G['defaultStrum'..i..'Y'],i)
        end 
    end
    if swayIntense then 
        for i = 0, 3 do 
			setActorX(_G['defaultStrum'..i..'X'] - 64 * math.sin((currentBeat + i*0)) + 16, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 16 * math.cos((currentBeat + i*32) * math.pi),i)
        end 
        for i = 4, 7 do 
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0)) - 16, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 16 * math.cos((currentBeat + i*32) * math.pi),i)
        end 
    end
    if swayIntense2 then 
        for i = 0, 3 do 
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0)) - 16, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*32) * math.pi),i)
        end 
        for i = 4, 7 do 
			setActorX(_G['defaultStrum'..i..'X'] - 64 * math.sin((currentBeat + i*0)) + 16, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*32) * math.pi),i)
        end 
    end
    if swayIntense3 then 
        for i = 0, 3 do 
			setActorX(_G['defaultStrum'..i..'X'] + 80 * math.sin((currentBeat + i*0)) - 16, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*32) * math.pi),i)
        end 
        for i = 4, 7 do 
			setActorX(_G['defaultStrum'..i..'X'] - 80 * math.sin((currentBeat + i*0)) + 16, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*32) * math.pi),i)
        end 
    end
    if swayIntense4 then 
        for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] - 320 * math.sin((currentBeat + i*0)) + 320, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*8) * math.pi),i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 320 * math.sin((currentBeat + i*0)) - 320, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 32 * math.cos((currentBeat + i*8) * math.pi),i)
		end
    end

	if zoom then
		camGame:tweenZoom(2, 1.37)
	end
	if hide then
		for i=0,7 do
			setActorAlpha(0,i)
		end
	end
   if swayingsmall then
    for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 16 * math.sin((currentBeat + i*6) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 2 * math.cos((currentBeat + i*3) * math.pi),i)
		end
   end
   if swayingreturn then
    for i=0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.5) * math.pi),i)
		end
   end
   if swayinglarge then
    for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0)), i)
			setActorY(_G['defaultStrum'..i..'Y'],i)
		end
   end
   if swayingbigger then
    for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 64 * math.sin((currentBeat + i*0) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*5) * math.pi) ,i)
		end
   end
   if swayingbiggest then
    for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin((currentBeat + i*0)) + 350, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 64 * math.cos((currentBeat + i*5) * math.pi),i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin((currentBeat + i*0)) - 275, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 64 * math.cos((currentBeat + i*5) * math.pi),i)
		end
   end
   if swayingbiggest2 then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin((currentBeat + i*0)) + 350, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 64 * math.cos((currentBeat + i*5) * math.pi),i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin((currentBeat + i*0)) - 275, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 64 * math.cos((currentBeat + i*5) * math.pi),i)
		end
	end
   if resetti then
		for i=0,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'], 0, 0.6, 'setDefault')
			tweenPosYAngle(i, _G['defaultStrum'..i..'Y'], 0, 0.6, 'setDefault')
		end
	end
	if hudrotate then
	camHudAngle = 5 * math.cos((currentBeat) * 1)
	cameraAngle = -5 * math.cos((currentBeat) * 1)
	end
	if hudrotatecalm then
	camHudAngle = 4 * math.cos((currentBeat) * 0.5)
	cameraAngle = -4 * math.cos((currentBeat) * 0.5)
	end
	if hudreset then
	camHudAngle = 0
	cameraAngle = 0
	end
	if spincenter then
		local currentBeat = (songPos / 1000)*(bpm/150)
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin((currentBeat + i*5) * math.pi)+ 360, i)
			setActorY(_G['defaultStrum'..i..'Y'],i)
		end
		for i=4,7 do	
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin((currentBeat + i*5) * math.pi)- 275, i)
			setActorY(_G['defaultStrum'..i..'Y'],i)
		end
	end
	if spinmaboi then
        if spinLength < 32 then
            spinLength = spinLength + 0.2
        end
	end
end

function partyDone()
    partied = false 
end

function beatHit (beat)
	if camerabeat then
		setCamZoom(1)
		setHudZoom(1)
	end
    end

function stepHit (step)
    if step == 2 then
        showOnlyStrums = true
        swayingsmall = true
    end
    if step == 2048 then
        showOnlyStrums = false
        swayingsmall = false
        resetti = true
    end
    if step == 2057 then
        resetti = false
    end
end

function playerOneTurn()
    tweenCameraZoom(0.65, 0.2)
end