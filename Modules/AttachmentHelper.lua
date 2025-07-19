local AttachmentHelper = {}
function AttachmentHelper.attach(part, limb, offset)
	-- Attachment on part: hit origin
	local hitAttachment = Instance.new("Attachment", part)
	hitAttachment.Name = "DmgPoint"  -- required by RaycastHitbox
	hitAttachment.Position = Vector3.new(0, 0, 0)

	-- Attachment on limb: constraint
	local limbAttachment = Instance.new("Attachment", limb)
	limbAttachment.Name = "HandAttach"
	limbAttachment.Position = offset

	return hitAttachment, limbAttachment
end
return AttachmentHelper

