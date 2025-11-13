local UIS = game:GetService("UserInputService")
local RL = game:GetService("ReplicatedStorage")

local Modules = RL:WaitForChild("Modules")
local AirplaneModules = Modules:WaitForChild("Airplane")
local controllerModule = require(AirplaneModules:WaitForChild("Controller"))

local enterCombatModeKey = Enum.KeyCode.F


UIS.InputBegan:Connect(function(input,gpe)
	
	if input.KeyCode == enterCombatModeKey then
		local control = controllerModule.new(workspace.Planes.Plane)
	end
	
	
	
end)

