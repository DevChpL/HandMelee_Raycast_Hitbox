local HitboxManager = {}
function HitboxManager.new(parts, raycastParams, RaycastHitbox)
	local self = { boxes = {} }
	for _, part in ipairs(parts) do
		-- RaycastHitbox expects attachment named "DmgPoint" on the part
		table.insert(self.boxes, RaycastHitbox.new(part, raycastParams))
	end
	function self:startAll()
		for _, hb in ipairs(self.boxes) do hb:HitStart() end
	end
	function self:stopAll()
		for _, hb in ipairs(self.boxes) do hb:HitStop() end
	end
	return self
end
return HitboxManager
