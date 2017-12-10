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
local btnS8
local posX = {display.contentWidth - 500, 50, 100,200,400,0,700}
local posY = {display.contentHeight -400,50,100,200, 400, 0,700}
local ganar = 4
local disp
local num = 15
---------------------------------------------------------------------------------

local nextSceneButton
local contador = 1
local function cronometro( )
    num = num - 1
    -- body
end
local function onPlayBtnRelease()
    
    -- go to level1.lua scene
    composer.gotoScene( "scene2", "fade", 500 )
    
    return true -- indicates successful touch
end
local function creaBoton ()
    
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



end
local function cambiaImagen()
    
        --btnS8:addEventListener("destroy",btnS8)
        num = 15
        contador = contador+1
        background = display.newImage("images/Foto_"..contador..".png" )
        background:translate( display.contentWidth/2, display.contentHeight/2 )
        disp = widget.newButton{
        width=154, height=40,
            shape = "roundedRect",
            fillColor = { default={0, 0.64313725490196, 0.83137254901961, 0.8 }, over={ 0.48235294117647, 0.64313725490196, 0.83137254901961, 1 } },
            onRelease = cambiaImagen
        }
        disp.x = 150
        disp.y = 1580
        disp.height = 360
        disp.width = 170
        local crono = display.newText(num, 1200,0, native.systemFont, 300)
        crono.anchorY = 0
        Runtime:addEventListener("enterFrame", cronometro)
        --btnS8= display.newImage("images/s8.png")
        
        --btnS8:translate( posX[contador],posY[contador])
        

        
    print (contador)
end
function scene:create( event )
    local sceneGroup = self.view
    background = display.newImage("images/Foto_"..contador..".png" )
    background:translate( display.contentWidth/2, display.contentHeight/2 )

    --disp = widget.newButton{
    --width=154, height=40,
    --    shape = "roundedRect",
    --    fillColor = { default={0, 0.64313725490196, 0.83137254901961, 0.8 }, over={ 0.48235294117647, 0.64313725490196, 0.83137254901961, 1 } },
    --    onRelease = cambiaImagen
    --}
    --disp.x = display.contentCenterX
    --disp.y = display.contentCenterY - 200
    --disp.height = 300
    --disp.width = 800
    --btnS8= display.newImage("images/s8.png")
    --btnS8:translate( posX[contador],posY[contador])
    --btnS8:addEventListener("tap", cambiaImagen)

    --Runtime:addEventListener("enterFrame", mueveBoton )
    sceneGroup:insert(background)
    --sceneGroup:insert(disp)
        

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    --creaBoton ()
    disp = widget.newButton{
    width=154, height=40,
        shape = "roundedRect",
        fillColor = { default={0, 0.64313725490196, 0.83137254901961, 0.8 }, over={ 0.48235294117647, 0.64313725490196, 0.83137254901961, 1 } },
        onRelease = cambiaImagen
    }
    disp.x = 900
    disp.y = 2450
    disp.height = 360
    disp.width = 170
    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
        local title = self:getObjectByName( "Title" )
        title.x = display.contentWidth / 2
        title.y = display.contentHeight / 2
        
        local crono = display.newText(num, 1200,0, native.systemFont, 300)
        crono.anchorY = 0
        local function manageTime( event )
             print( event.time/1000 )
        end
 
        timer.performWithDelay( 1000, manageTime, 0 )
        Runtime:addEventListener("enterFrame", cronometro)

        


        
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        -- we obtain the object by id from the scene's object hierarchy
        --btnS8:addEventListener("tap", cambiaImagen)
        nextSceneButton = self:getObjectByName( "GoToScene2Btn" )
        if nextSceneButton then
        	-- touch listener for the button
        	function nextSceneButton:touch ( event )
        		local phase = event.phase
        		if contador== ganar then
        			composer.gotoScene( "scene2", { effect = "fade", time = 300 } )
        		end
        	end
        	-- add the touch event listener to the button
        	nextSceneButton:addEventListener( "touch", nextSceneButton )
            --if  then
            --composer.gotoScene( "scene2", { effect = "fade", time = 300 } )
        --end--
        end
        
    end 
    
        
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
