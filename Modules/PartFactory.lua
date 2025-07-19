local PartFactory = {}
function PartFactory.create(size, color)
	local p = Instance.new("Part")
	p.Size = size
	p.Color = color
	p.Anchored = false
	p.CanCollide = false
	p.Parent = workspace
	return p
end
return PartFactory
