---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local widget = require "widget"

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )
local background
local btnS8  --1   2    3   4    5   6   7   8   9   10   11  12   13  14  15  16  17  18  19  20  21   22  23  24   25  26  27  28
local posX = {900,1340,440,1120,430,350,650,760,1220,280,1300,560,800,150,340,150,640,1050,240,720,940,400,830,800, 425,150,650,150}
--            1      2    3   4    5     6    7   8    9    10   11  12   13  14    15   16   17   18   19   20   21   22  23   24    25   26   27   28  
local posY = {2450,2050,1200,1750,1910,1380,2640,1750,2390,2200,1000,850,1370,1580,2200,2340,2450,1730,2290,1150,910,1650,2000,1900,2270,2100,2200,1750}
local ganar = 4
local disp

local startTime = 15
local pausedAt = 15
local timeDelay = 100  -- 1/10th of a second ( 1000 milliseconds / 10 = 100 )
local timerIterations = 150  -- Set the timer limit to 60 seconds ( 600 * 0.1 = 60 )
---------------------------------------------------------------------------------
local runMode = "stopped"

local nextSceneButton
local contador = 1
local bandera = false
local countTxt

local timerID
local count = 15
local aleatorios = {}
math.randomseed( os.time() )
aleatorios[1]= math.random( 1, 28 )
for i=2, 10 do
  value=math.random( 1, 28 )
  for j=1, #aleatorios do
    if value ==aleatorios[j] then
      value=math.random( 1, 28 )
      print("repetido"..value)
      j=1
    end
  end
 aleatorios[i]=value
 print(aleatorios[i])
end

--[[local function creaBoton ()
    
    --disp:translate( posX[contador],posY[contador])
    disp = widget.newButton{
    width=154, height=40,
        shape = "roundedRect",
        fillColor = { default={0, 0.64313725490196, 0.83137254901961, 0.8 }, over={ 0.48235294117647, 0.64313725490196, 0.83137254901961, 1 } },
        onRelease = cambiaImagen
    }
    disp.x = display.contentCenterX
    disp.y = display.contentCenterY - 200
    disp.height = 300
    disp.width = 800
end]]

local function cambiaImagen(event)
    
        if background ~= nil then
            background:removeSelf()
            background = nil
            
            disp:removeSelf()
            disp = nil

            countTxt:removeSelf()
            countTxt = nil
        end

        if (timerID ~= nil) then
            print("hi")

            timer.cancel( timerID )
        end

        
        background = display.newImage("images/Foto_"..aleatorios[contador]..".png" )
        background:translate( display.contentWidth/2, display.contentHeight/2 )
        
        disp = widget.newButton{
            width=154, height=40,
            shape = "roundedRect",
            fillColor = { default={0, 0.64313725490196, 0.83137254901961, 0.05 }, over={ 0.48235294117647, 0.64313725490196, 0.83137254901961, 0.05 } },
            onRelease = cambiaImagen
        }

        disp.x = posX[aleatorios[contador]]
        disp.y = posY[aleatorios[contador]]
        disp.height = 360
        disp.width = 170

        contador = contador+1

        if contador == 11 then
            background:removeSelf()
            background = nil

            disp:removeSelf()
            disp = nil

            
            countTxt = nil
            composer.gotoScene( "Final", "fade", 5)
            
        end

        count = 15
        
        countTxt = display.newText( count, 1200,200, system.nativeFont, 300 )
        countTxt:setFillColor( 1, 1, 1 )
        --anchorY=0
        
        local function repeatFade1 (event)
            count = count - 1
            countTxt.text = count
            if count == -1 then
                background = display.newImage("images/Condiciones/Incorrect.png" )
                background:translate( display.contentWidth/2, display.contentHeight/2 )
            elseif count == -2 then
                cambiaImagen()
            end
        end
        
        timerID = timer.performWithDelay(1000, repeatFade1, 17 )

    
        --crono:toFront()
        
    print (contador)
end
function scene:create( event )
    local sceneGroup = self.view
    
    --sceneGroup:insert(background)

    cambiaImagen()
    

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    

    if phase == "will" then
        
    elseif phase == "did" then

    end 
    
    -- Called when the scene is now on screen
    -- 
    -- INSERT code here to make the scene come alive
    -- e.g. start timers, begin animation, play audio, etc
            
        
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
    countTxt:removeSelf()

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end



---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
