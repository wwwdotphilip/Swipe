local storyboard = require"storyboard";
local widget = require"widget";
local scene = storyboard.newScene();
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
    if t.name == "back" then
        storyboard.gotoScene("class.menu", "crossFade", 100)
    end
end

function scene:createScene( event )
    screenGroup = self.view;
    
    btn.back = widget.newButton{
        label = "Back",
        width = 160,
        height = 80,
        fontSize = 60,
        onRelease = func.buttonEvent
    }
    btn.back.x = num.W - 90; btn.back.y = 40;
    btn.back.name = "back";
    screenGroup:insert(btn.back);
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


