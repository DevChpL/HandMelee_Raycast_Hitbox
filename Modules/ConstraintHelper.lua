local ConstraintHelper = {}
function ConstraintHelper.rigid(a0, a1)
	local rc = Instance.new("RigidConstraint")
	rc.Attachment0 = a0
	rc.Attachment1 = a1
	rc.Parent = a0.Parent  -- parent to part so it stays in workspace
	return rc
end
return ConstraintHelper
