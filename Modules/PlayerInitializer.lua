local Config            = require(script.Config)
local PartFactory       = require(script.PartFactory)
local AttachmentHelper  = require(script.AttachmentHelper)
local ConstraintHelper  = require(script.ConstraintHelper)
local HitboxManager     = require(script.HitboxManager)
local Promise           = require(game.ReplicatedStorage.Modules.Promise)
local RaycastHitbox     = require(game.ReplicatedStorage.Modules.RaycastHitboxV4)

game.Players.PlayerAdded:Connect(function(plr)
	local char = plr.Character or plr.CharacterAdded:Wait()

	-- Setup RaycastParams per-player
	local params = RaycastParams.new()
	params.FilterType = Config.RaycastParams.FilterType
	params.FilterDescendantsInstances = {char}

	-- Create parts, attachments, constraints
	local parts = {}
	for _, limbName in ipairs(Config.Limbs) do
		local limb = char:WaitForChild(limbName)
		local part = PartFactory.create(Config.PartSize, Config.PartColor)
		part.CFrame = limb.CFrame
		local a0, a1 = AttachmentHelper.attach(part, limb, Config.AttachmentOffset)
		ConstraintHelper.rigid(a0, a1)
		table.insert(parts, part)
	end

	-- Build and start hitboxes
	local manager = HitboxManager.new(parts, params, RaycastHitbox)
	manager:startAll()
end)
