local module = {}

local Types = require(script.Parent.Parent.ControllerTypes)
type ControllerInstance = Types.ControllerInstance
-- hello test hello test
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
-- tesitnt rojo 
local mouseSensitivity = 0.004
local touchSensitivity = 0.005 -- Slightly different for touch
local scrollMoveSpeed = 2

local maxPitchRadians = math.rad(80)

module.initCamera = function(Controller:ControllerInstance)
	
	local camera = Controller.camera
	local camPart = Controller.camPart
	
	camera.CameraType = Enum.CameraType.Scriptable
	
	if not UIS.TouchEnabled then
		UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
	end
	
	local lastTouchPosition = nil
	local currentInputObject = nil
	
	local currentYaw = 0
	local currentPitch = 0
	
	
	if UIS.MouseEnabled then
		local rStepConn = RS.RenderStepped:Connect(function(dt)


			local mouseDelta = UIS:GetMouseDelta()

			currentYaw = currentYaw - mouseDelta.X * mouseSensitivity

			currentPitch = currentPitch - mouseDelta.Y * mouseSensitivity
			currentPitch = math.clamp(currentPitch, -maxPitchRadians,maxPitchRadians)

			camera.CFrame = 
				CFrame.new(camPart.CFrame.Position) * 
				CFrame.Angles(0,currentYaw,0) * 
				CFrame.Angles(currentPitch, 0, 0)


		end)

		table.insert(Controller.rbxscriptconns,rStepConn)
	end
	
	local inputBeganConn = UIS.InputChanged:Connect(function(input,gpe)

		if gpe then return end
		
		if input.UserInputType == Enum.UserInputType.Touch and lastTouchPosition and currentInputObject == input then
			
			local delta = input.Position - lastTouchPosition

			-- Rotate left/right (yaw)
			local yaw = -delta.X * mouseSensitivity
			currentYaw = currentYaw + math.rad(yaw)
			
			-- Adjust vertical rotation (pitch) and clamp it
			local pitchChange = -delta.Y * mouseSensitivity
			currentPitch = math.clamp(currentPitch + math.rad(pitchChange), -maxPitchRadians,maxPitchRadians)

			-- Apply the new camera rotation
			local newCFrame = CFrame.new(camera.CFrame.Position) * CFrame.Angles(0, currentYaw, 0) * CFrame.Angles(currentPitch, 0, 0)
			camera.CFrame = newCFrame


		end

		if input.UserInputType == Enum.UserInputType.Touch and (currentInputObject == input or currentInputObject == nil) then
			lastTouchPosition = input.Position
			currentInputObject = input

		end
	end)
	
	table.insert(Controller.rbxscriptconns,inputBeganConn)
	
	local inputEndedConn = UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch and input == currentInputObject then
			lastTouchPosition = nil
			currentInputObject = nil
		end
	end)
	
	table.insert(Controller.rbxscriptconns,inputEndedConn)
	
end

return module
