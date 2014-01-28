local storyboard = require"storyboard";
local scene = storyboard.newScene();
local widget = require"widget";
widget.setTheme( "widget_theme_ios" )
local screenGroup;

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
    num.W = display.contentWidth;
    num.H = display.contentHeight;
end
func.initVar();

function func.buttonEvent(event)
    local t = event.target;
    if t.name == "start" then
        storyboard.gotoScene("class.game", "crossFade", 100)
    elseif t.name == "option" then
        storyboard.gotoScene("class.option", "crossFade", 100)
    end
end

function scene:createScene( event )
    screenGroup = self.view;
    
    text.title = display.newText(screenGroup, "SWIPE", 0, 0, native.systemFont, 140);
    text.title.x = num.W * .5; text.title.y = num.H * .5 - 100;
    
    btn.start = widget.newButton{
        label = "Start Game",
        fontSize = 60,
        width = 380,
        height = 80,
        onRelease = func.buttonEvent,
    }
    btn.start.x = num.W * .5; btn.start.y = num.H * .5 + 50;
    btn.start.name = "start";
    screenGroup:insert(btn.start);
    
    btn.option = widget.newButton{
        label = "Options",
        fontSize = 60,
        width = 260,
        height = 80,
        onRelease = func.buttonEvent,
    }
    btn.option.x = num.W * .5; btn.option.y = num.H * .5 + 140;
    btn.option.name = "option";
    screenGroup:insert(btn.option);
end

function scene:enterScene( event )
    local prev = storyboard.getPrevious();
    if prev ~= nil then
        storyboard.removeScene(prev);
    end
end

function scene:exitScene( event )
    scene:removeEventListener( "createScene", scene );
    scene:removeEventListener( "enterScene", scene );
    scene:removeEventListener( "exitScene", scene );
    scene:removeEventListener( "destroyScene", scene );
end

function scene:destroyScene( event )
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
