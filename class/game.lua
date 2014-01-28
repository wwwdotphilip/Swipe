local storyboard = require"storyboard";
local widget = require"widget"
widget.setTheme( "widget_theme_ios" )
local scene = storyboard.newScene();
local screenGroup;
local physics = require"physics";

local btn = {}
local num = {}
local str = {}
local bol = {}
local scrl = {}
local text = {}
local img = {}
local rect = {}
local crcl = {}
local line = {}
local tab = {}
local swt = {}
local tmr = {}
local tran = {}
local func = {}

function func.initVar()
    physics.start();
    physics.setGravity(0, 0)
--    physics.setDrawMode("debug")
    num.W = display.contentWidth;
    num.H = display.contentHeight;
    num.moves = 7;
    
    num.linecoor = {
        {num.W*.5, num.H - 20, num.W - 20, 30},
        {num.W*.7, num.H*.5, num.W*.2, 30},
        {num.W*.29, num.H*.5-100, num.W*.25, 30},
        {num.W*.4, num.H*.09, num.W - 200, 30},
        {num.W*.3, num.H*.8, 30, num.H - 420},
        {num.W*.6, num.H*.42, 30, num.H - 220},
        {num.W*.8, num.H*.85, 30, num.H - 480},
        {num.W*.98, num.H*.53, 30, num.H - 120},
    }
end

function func.onTouch(event)
        local phase = event.phase
        local t = event.target
        if phase == "moved" then
            if num.moves > 0 and crcl.ball.moveable then
                print(t.move)
                local dx = math.abs( event.x - event.xStart )
                local dy = math.abs( event.y - event.yStart )
                
                if dx > 20 then
                    crcl.ball.moveable = false
                    
                    if event.x > event.xStart then
                        if t.move ~= "left" then
                            tran.ball = transition.to(t, {time = 600, x = num.W})
                            t.move = "left"
                            num.moves = num.moves - 1;
                            text.moves.text = "Moves left:" .. num.moves
                        end
                    else
                        if t.move ~= "right" then
                            tran.ball = transition.to(t, {time = 600, x = 0})
                            t.move = "right"
                            num.moves = num.moves - 1;
                            text.moves.text = "Moves left:" .. num.moves
                        end
                    end
                elseif dy > 20 then
                    crcl.ball.moveable = false
                    
                    if event.y > event.yStart then
                        if t.move ~= "down" then
                            tran.ball = transition.to(t, {time = 600, y = num.H})
                            t.move = "down"
                            num.moves = num.moves - 1;
                            text.moves.text = "Moves left:" .. num.moves
                        end
                    else
                        if t.move ~= "up" then
                            tran.ball = transition.to(t, {time = 600, y = 0})
                            t.move = "up"
                            num.moves = num.moves - 1;
                            text.moves.text = "Moves left:" .. num.moves
                        end
                    end
                end
            end
        end
    
--    local d = event.target
--    
--    local phase = event.phase
--    if "began" == phase then
--        display.getCurrentStage():setFocus(d)
--        d.isFocus = true
--        d.x0 = event.x - d.x
--        d.y0 = event.y - d.y
--    elseif d.isFocus then
--        if "moved" == phase then
--            d.x = event.x - d.x0
--            d.y = event.y - d.y0
--        elseif "ended" == phase or "cancelled" == phase then
--            display.getCurrentStage():setFocus( nil )
--            d.isFocus = false
--        end
--    end
--    return true
end

function func.quit()
    physics.stop();
    storyboard.gotoScene("class.menu", "crossFade", 100)
end

function func.buttonEvent(event)
    local t = event.target;
    if t.name == "quit" then
        native.showAlert("Quit game", "Are you sure?", {"Yes", "No"}, func.wonListener)
    end
end

function func.wonListener(event)
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
            func.quit();
        elseif 2 == i then
            
        end
    end
end

function func.onCollision(event)
    local phase = event.phase
    local o1 = event.object1
    local o2 = event.object2
--    transition.cancel(tran.ball)
    print(o1.name, o2.name, num.moves)
    
    if phase == "began" then
        print("Began")
        if o1.name == "goal" then
            native.showAlert("You won", "Congratulations", {"Okay"}, func.wonListener)
        else
            if num.moves == 0 then
                native.showAlert("Game over", "You ran out of moves", {"Close"}, func.wonListener)
            end
        end
        transition.cancel()
        tran.ball = nil
        crcl.ball.moveable = true
    elseif phase == "ended" then
        print("Ended");
    end
end

function scene:createScene( event )
    func.initVar();
    screenGroup = self.view;
    
    crcl.ball = display.newCircle(screenGroup, 80, num.H - 80, 40);
    crcl.ball:setFillColor(0, 255, 0);
    crcl.ball.moveable = true;
    crcl.ball.name = "ball";
    crcl.ball.move = "down";
    
    text.goal = display.newText(screenGroup, "Goal", 0, 0, native.systemFont, 40)
    text.goal:setTextColor(190, 190, 190);
    text.goal.x = num.W - 100;text.goal.y = 40;
    text.goal.name = "goal"
    
    text.moves = display.newText(screenGroup, "Moves left:" .. num.moves, 400, 20, native.systemFont, 35)
    text.moves:setTextColor(190, 190, 190);
    
    btn.quit = widget.newButton{
        top = 0,
        left = 0,
        width = 90,
        height = 40,
        label = "QUIT",
        fontSize = 28,
        onRelease = func.buttonEvent,
    }
    btn.quit.name = "quit"
    screenGroup:insert(btn.quit);
    
    for i=1,#num.linecoor do
        line[i] = display.newRect(screenGroup, num.linecoor[i][1],num.linecoor[i][2],num.linecoor[i][3],num.linecoor[i][4]);
        line[i]:setFillColor(0, 0, 255);
        line[i].name = "line"
        physics.addBody(line[i], "static", {friction = 0, bounce = 0, density = 0})
    end
end

function scene:enterScene( event )
    local prev = storyboard.getPrevious();
    if prev ~= nil then
        storyboard.removeScene(prev);
    end
    physics.addBody(text.goal, "static", {friction = 0, bounce = 0, density = 0})
    physics.addBody(crcl.ball, "dynamic", {friction = 0, bounce = 0.2, density = 0, radius = 40})
    crcl.ball:addEventListener("touch", func.onTouch);
    Runtime:addEventListener("collision", func.onCollision)
end

function scene:exitScene( event )
    crcl.ball:removeEventListener( "touch", func.onTouch );
    Runtime:removeEventListener("collision", func.onCollision)
    scene:removeEventListener( "createScene", scene );
    scene:removeEventListener( "enterScene", scene );
    scene:removeEventListener( "exitScene", scene );
    scene:removeEventListener( "destroyScene", scene );
end

function scene:destroyScene( event )
    physics = nil
    widget = nil
    btn = nil
    num = nil
    str = nil
    bol = nil
    scrl = nil
    text = nil
    img = nil
    rect = nil
    crcl = nil
    line = nil
    tab = nil
    swt = nil
    tmr = nil
    tran = nil
    func = nil
end

scene:addEventListener( "createScene", scene );
scene:addEventListener( "enterScene", scene );
scene:addEventListener( "exitScene", scene );
scene:addEventListener( "destroyScene", scene );

return scene;


