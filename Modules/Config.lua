local Config = {
	Limbs = {"Left Arm", "Right Arm"},
	PartSize = Vector3.new(1.2, 1.2, 1.2),
	PartColor = Color3.fromRGB(255, 0, 0),
	AttachmentOffset = Vector3.new(0, -0.7, 0),
	RaycastParams = {
		FilterType = Enum.RaycastFilterType.Exclude,
		-- FilterDescendantsInstances will be set per-player
	}
}
return Config