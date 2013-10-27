--- kidutils.spriteutils.lua: This is a collection of helper utilities to handle Gideros sprites.
--- Author: Maurício Gomes 
---

local system = {};
local contentCenterX = application:getContentWidth()/2;
local contentCenterY = application:getContentHeight()/2;

local function touchStop( event )
	event:stopPropagation();
end

function system.CenterOnScreen( target )
	target:setAnchorPoint(0.5, 0.5);
	target:setPosition(contentCenterX, contentCenterY);
end

function system.setTouchBlocker( target )
	target:addEventListener(Event.TOUCHES_END, touchStop);
	target:addEventListener(Event.TOUCHES_BEGIN, touchStop);
	target:addEventListener(Event.TOUCHES_MOVE, touchStop);
	target:addEventListener(Event.TOUCHES_CANCEL, touchStop);
	target:addEventListener(Event.REMOVED_FROM_STAGE, system.cancelTouchBlocker, target);
end

function system.cancelTouchBlocker( event, target )
	if not target then target = event end --this allow the API to be used both as event, and as normal function
	if not target.removeEventListener then return end --target was called in a event, but was deleted when we ran
	target:removeEventListener(Event.TOUCHES_END, touchStop);
	target:removeEventListener(Event.TOUCHES_BEGIN, touchStop);
	target:removeEventListener(Event.TOUCHES_MOVE, touchStop);
	target:removeEventListener(Event.TOUCHES_CANCEL, touchStop);
	target:removeEventListener(Event.REMOVED_FROM_STAGE, system.cancelTouchBlocker, target);
end

system.OFFSET_Y = application:getLogicalTranslateY()/application:getLogicalScaleY();
system.OFFSET_X = application:getLogicalTranslateX()/application:getLogicalScaleX();
system.CENTER_X = application:getContentWidth()/2;
system.CENTER_Y = application:getContentHeight()/2;

return system;