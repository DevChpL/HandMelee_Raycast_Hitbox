``lua
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
	-- Wait for their character to load in
	local character = player.Character or player.CharacterAdded:Wait()

	-- Set up raycast parameters - filter out the character itself
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Config.RaycastParams.FilterType
	rayParams.FilterDescendantsInstances = { character }

	local hitParts = {}

	-- Loop through each limb we care about
	for _, limbName in ipairs(Config.Limbs) do
		local limb = character:WaitForChild(limbName)

		-- Spawn a custom part that’ll act as our hitbox piece
		local newPart = PartFactory.create(Config.PartSize, Config.PartColor)
		newPart.CFrame = limb.CFrame -- align to the limb initially

		-- Attach points (why two? one for hitbox, one for limb)
		local hitAttachment, limbAttachment = AttachmentHelper.attach(newPart, limb, Config.AttachmentOffset)

		-- Connect them together rigidly, so no wobbles
		ConstraintHelper.rigid(hitAttachment, limbAttachment)

		table.insert(hitParts, newPart)
	end

	-- Spin up the hitbox manager to track all of this
	local hitboxMgr = HitboxManager.new(hitParts, rayParams, RaycastHitbox)
	hitboxMgr:startAll() -- start detecting hits
end)
``
