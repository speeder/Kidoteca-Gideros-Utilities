--- kidutils.shapeutils.lua: This is a collection of helper utilities to draw vector shapes.
--- Author: Maurício Gomes 
---

local system = {};

system.Rectangle = Core.class(Shape);

function system.Rectangle.setBounds(self, x1, y1, x2, y2)
	self:clear();        -- Clear the canvas of any previous drawing it may have
	self:beginPath();    -- Start all drawing 

	if self.fillTexture then
		self:setFillStyle(Shape.TEXTURE, self.fillTexture, self.fillMatrix);
	else
		self:setFillStyle(Shape.SOLID, self.fillColor or 0xFFFFFF, self.fillAlpha or 1);
	end
	self:setLineStyle(self.lineWidth or 0, self.lineColor or 0x000000, self.lineAlpha or 1);

	self:moveTo(x1, y1);
	self:lineTo(x1, y2);
	self:lineTo(x2 ,y2);
	self:lineTo(x2 ,y1);
	self:lineTo(x1 ,y1);

	self:endPath();      -- Finish drawing
end

return system;