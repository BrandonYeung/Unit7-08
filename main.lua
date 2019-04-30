-----------------------------------------------------------------------------------------
--Created on April 30, 2019
-- main.lua
--Created by Brandon Yeung
-----------------------------------------------------------------------------------------

local physics = require( "physics" )

physics.start()
physics.setGravity( 0, 25 ) -- ( x, y )
--physics.setDrawMode( "hybrid" )   -- Shows collision engine outlines only
local playerBullets = {}

local theGround = display.newImageRect( "assets/land.png", 300, 90 )
theGround.x = display.contentCenterX
theGround.y = display.contentCenterY +100
theGround.id = "the ground"
physics.addBody( theGround, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 25 ) -- ( x, y )

local leftWall = display.newRect( 0, display.contentHeight, 50, 1000, 1, display.contentHeight )
-- myRectangle.strokeWidth = 10
-- myRectangle:setFillColor( 0.5 )
-- myRectangle:setStrokeColor( 1, 0, 0 )
leftWall.alpha = 1
leftWall.id = " leftWall"
physics.addBody( leftWall, "static", { 
    friction = 1.5, 
    bounce = 0.
    } )
-- Character move

local dPad = display.newImageRect( "assets/d-pad.png", 90, 90  )
dPad.x = display.contentCenterX
dPad.y = display.contentCenterY + 200
dPad.id = "d-pad"



local upArrow = display.newImageRect ("assets/upArrow.png", 24, 14  )
upArrow.x = display.contentCenterX
upArrow.y = display.contentCenterY + 168
upArrow.id = "up arrow"

local downArrow = display.newImageRect ("assets/downArrow.png", 24, 14  )
downArrow.x = display.contentCenterX
downArrow.y = display.contentCenterY + 232
downArrow.id = "down arrow"

local leftArrow = display.newImageRect ("assets/leftArrow.png", 14, 24  )
leftArrow.x = display.contentCenterX - 34
leftArrow.y = display.contentCenterY + 202
leftArrow.id = "left arrow"

local rightArrow = display.newImageRect ("assets/rightArrow.png", 14, 24  )
rightArrow.x = display.contentCenterX + 34
rightArrow.y = display.contentCenterY + 202
rightArrow.id = "left arrow"

local theCharacter = display.newImageRect( "assets/Idle.png", 45, 75  )
theCharacter.x = display.contentCenterX
theCharacter.y = display.contentCenterY- 100
theCharacter.id = "The Character"
 physics.addBody( theCharacter, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )
 theCharacter.isFixedRotation = true 

local jumpButton = display.newImageRect( "assets/jumpButton.png" ,90,90)
jumpButton.x = display.contentCenterX + 100
jumpButton.y = display.contentCenterY + 200
jumpButton.id = "jump button"
jumpButton.alpha = 0.5

local theCharacter2 = display.newImageRect( "assets/Idle2.png", 45, 75  )
theCharacter2.x = 200
theCharacter2.y = 200
theCharacter2.id = "The Character 2"
 physics.addBody( theCharacter2, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )

local shootButton = display.newImageRect( "assets/jumpButton.png",60,60 )
shootButton.x = display.contentWidth - 250
shootButton.y = display.contentHeight - 80
shootButton.id = "shootButton"
shootButton.alpha = 0.5

local shootButton2 = display.newImageRect( "assets/jumpButton.png",60,60 )
shootButton2.x = display.contentWidth - 250
shootButton2.y = display.contentHeight - 20
shootButton2.id = "shootButton"
shootButton2.alpha = 0.5
local function characterCollision( self, event )
 
    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end

    
if #playerBullets > 0 then
        for bulletCounter = #playerBullets, 1 ,-1 do
            if playerBullets[bulletCounter].x > display.contentWidth + 1000 then
                playerBullets[bulletCounter]:removeSelf()
                playerBullets[bulletCounter] = nil
                table.remove(playerBullets, bulletCounter)
                print("remove bullet")
            end
        end
    end

local function onCollision( event )
 
    if ( event.phase == "began" ) then
 
        local obj1 = event.object1
        local obj2 = event.object2
        local whereCollisonOccurredX = obj1.x
        local whereCollisonOccurredY = obj1.y

        if ( ( obj1.id == "The Character 2" and obj2.id == "bullet" ) or
             ( obj1.id == "bullet" and obj2.id == "The Character 2" ) ) then
            -- Remove both the laser and asteroid
            --display.remove( obj1 )
            --display.remove( obj2 )
 			
 			-- remove the bullet
 			local bulletCounter = nil
 			
            for bulletCounter = #playerBullets, 1, -1 do
                if ( playerBullets[bulletCounter] == obj1 or playerBullets[bulletCounter] == obj2 ) then
                    playerBullets[bulletCounter]:removeSelf()
                    playerBullets[bulletCounter] = nil
                    table.remove( playerBullets, bulletCounter )
                    break
                end
            end

            --remove character
            theCharacter2:removeSelf()
            theCharacter2 = nil

            -- Increase score
            print ("you could increase a score here.")

            -- make an explosion sound effect
            local expolsionSound = audio.loadStream( "assets/8bit_bomb_explosion.wav" )
            local explosionChannel = audio.play( expolsionSound )

            -- make an explosion happen
            -- Table of emitter parameters
			local emitterParams = {
			    startColorAlpha = 1,
			    startParticleSizeVariance = 50,
			    startColorGreen = 0.3031555,
			    yCoordFlipped = -1,
			    blendFuncSource = 770,
			    rotatePerSecondVariance = 153.95,
			    particleLifespan = 0.7237,
			    tangentialAcceleration = -1440.74,
			    finishColorBlue = 0.3699196,
			    finishColorGreen = 0.5443883,
			    blendFuncDestination = 1,
			    startParticleSize = 20.95,
			    startColorRed = 0.8373094,
			    textureFileName = "assets/fire.png",
			    startColorVarianceAlpha = 1,
			    maxParticles = 56,
			    finishParticleSize = 40,
			    duration = 0.25,
			    finishColorRed = 1,
			    maxRadiusVariance = 7.63,
			    finishParticleSizeVariance = 50,
			    gravityy = -671.05,
			    speedVariance = 0.79,
			    tangentialAccelVariance = -420.11,
			    angleVariance = -142.62,
			    angle = -244.11
			}
			local emitter = display.newEmitter( emitterParams )
			emitter.x = whereCollisonOccurredX
			emitter.y = whereCollisonOccurredY

        end
    end
end

function upArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 0, -- move 0 in the x direction 
        	y = -50, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    

    return true
end

function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = -50, -- move 50 pixels  to the left 
        	y = 0, -- move  0 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end
return true
end

function downArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 0, -- move 0 in the x direction 
        	y = 50, -- move down 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end
return true
end

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 50, -- move right 50 pixels
        	y = 0, -- move up 0 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end
return true
end

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- make the character jump
        theCharacter:setLinearVelocity( 0, -750 )
    end

    return true
end
function shootButton:touch( event )
    if ( event.phase == "began" ) then
        -- make a bullet appear
        local aSingleBullet = display.newImageRect( "assets/Kunai.png" ,20,10 )
        aSingleBullet.x = theCharacter.x
        aSingleBullet.y = theCharacter.y

        physics.addBody( aSingleBullet, 'dynamic' )
        -- Make the object a "bullet" type object
        aSingleBullet.isBullet = true
        aSingleBullet.gravityScale = 0
        aSingleBullet.id = "bullet"
        aSingleBullet:setLinearVelocity( 1500, 0 )

        table.insert(playerBullets,aSingleBullet)
        print("# of bullet: " .. tostring(#playerBullets))
    end

    return true
end

function shootButton2:touch( event )
    if ( event.phase == "began" ) then
        -- make a bullet appear
        local aSingleBullet2 = display.newImageRect( "assets/Kunai.png" ,-20,10 )
        aSingleBullet2.x = theCharacter.x-50
        aSingleBullet2.y = theCharacter.y
        physics.addBody( aSingleBullet2, 'dynamic' )
        -- Make the object a "bullet" type object
        aSingleBullet2.isBullet = true
        aSingleBullet2.gravityScale = 0
        aSingleBullet2.id = "bullet"
        aSingleBullet2:setLinearVelocity( 1500, 0 )

        table.insert(playerBullets,aSingleBullet)
        print("# of bullet: " .. tostring(#playerBullets))
    end

    return true
end


-- if character falls off the end of the world, respawn back to where it came from
function checkCharacterPosition( event )
    -- check every frame to see if character has fallen
    if theCharacter.y > display.contentHeight + 150 then
        theCharacter.x = display.contentCenterX - 100
        theCharacter.y = display.contentCenterY
    end
end

upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
leftArrow:addEventListener( "touch", leftArrow )
rightArrow:addEventListener( "touch", rightArrow )
jumpButton:addEventListener( "touch", jumpButton )
Runtime:addEventListener( "enterFrame", checkCharacterPosition )
--theCharacter.collision = characterCollision
--theCharacter:addEventListener( "collision" )
shootButton:addEventListener( "touch", shootButton )
shootButton2:addEventListener( "touch", shootButton2 )
Runtime:addEventListener( "collision", onCollision )