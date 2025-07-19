local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules

-- Configs and utility helpers
local Config = require(Modules.Config)
local PartFactory = require(Modules.PartFactory)
local AttachmentHelper = require(Modules.AttachmentHelper)
local ConstraintHelper = require(Modules.ConstraintHelper)
local HitboxManager = require(Modules.HitboxManager)

-- External dependencies
local Promise = require(Modules.Promise) -- I don’t think we use this yet?
local RaycastHitbox = require(Modules.RaycastHitboxV4)

local Players = game:GetService("Players")

-- Player joins the game
Players.PlayerAdded:Connect(function(player)
	local character = player.Character or player.CharacterAdded:Wait()

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Config.RaycastParams.FilterType
	rayParams.FilterDescendantsInstances = { character }

	local hitParts = {}

	for _, limbName in ipairs(Config.Limbs) do
		local limb = character:WaitForChild(limbName)

		local newPart = PartFactory.create(Config.PartSize, Config.PartColor)
		newPart.CFrame = limb.CFrame

		local hitAttachment, limbAttachment = AttachmentHelper.attach(newPart, limb, Config.AttachmentOffset)

		ConstraintHelper.rigid(hitAttachment, limbAttachment)

		table.insert(hitParts, newPart)
	end

	local hitboxMgr = HitboxManager.new(hitParts, rayParams, RaycastHitbox)
	hitboxMgr:startAll()
end)
