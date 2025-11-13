local module = {}

module.propellerRotate = function(planeModel:Model,propellerImage:ImageLabel)

	local rotationSpeed = 2.5

	while planeModel.Parent == workspace.Planes do
		propellerImage.Rotation = propellerImage.Rotation + rotationSpeed
		
		task.wait()
	end
end

return module
