-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn1
local background
local countTxt

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
    
    -- go to level1.lua scene

    composer.gotoScene( "scene1", "fade", 500)

    return true -- indicates successful touch
end

local   function transicion()
        background:removeSelf()
        playBtn1:removeSelf()
        count = 3
        countTxt = display.newText( count, display.contentCenterX, display.contentCenterY, system.nativeFont, 300 )
        countTxt:setFillColor( 1, 1, 1 )
        
        local function repeatFade (event)
            count = count - 1
            countTxt.text = count
            if count == 0 then
                composer.gotoScene( "scene1", "fade", 5)
                countTxt:removeSelf() 

            end

        end
        
        -- Fade out rectangle every second 20x using transition.to()       
        timer.performWithDelay(1000, repeatFade, 3 )
        

end

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist.
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
    local contador= 0
    --r = display.newRect( display.contentCenterX, display.contentCenterY, 150, 150 )
    -- display a background image
    background = display.newImageRect( "images/instrucciones/instrucciones"..contador..".png", display.actualContentWidth, display.actualContentHeight )
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0 + display.screenOriginX 
    background.y = 0 + display.screenOriginY
    local function repeatFade (event)
        background:removeSelf()
        --r.alpha = 1
        --transition.to( r, { alpha=0, time=1000 } )
        contador = contador + 1
        background = display.newImageRect( "images/instrucciones/instrucciones"..contador..".png", display.actualContentWidth, display.actualContentHeight )
        background.anchorX = 0
        background.anchorY = 0
        background.x = 0 + display.screenOriginX 
        background.y = 0 + display.screenOriginY
        if contador == 4 then
            playBtn1 = widget.newButton{
            label="Jugar",
            labelColor = { default={255}, over={128} },
            default="button.png",
            over="button-over.png",
            width=154, height=40,
            shape = "roundedRect",
            fillColor = { default={0, 0.64313725490196, 0.83137254901961, 0.8 }, over={ 0.48235294117647, 0.64313725490196, 0.83137254901961, 1 } },
            onRelease = transicion   -- event listener function
            }
            playBtn1.x = display.contentCenterX
            playBtn1.y = 2000
            playBtn1.height = 300
            playBtn1.width = 800
        end
    end
    timer.performWithDelay(3000, repeatFade, 4 )
    
     --create/position logo/title image on upper-half of the screen
    
         --create a widget button (which will loads level1.lua on release)
        
    --
    -- all display objects must be inserted into group
    sceneGroup:insert( background )
   
    --sceneGroup:insert( playBtn1 )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc.
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
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view
    
    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.
    
    if countTxt then
        countTxt:removeSelf()    -- widgets must be manually removed
        countTxt = nil
    end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene