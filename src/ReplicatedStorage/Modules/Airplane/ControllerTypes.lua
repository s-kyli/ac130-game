
export type ControllerInstance = {
	camera: Camera,
	camPart: Part,
	rbxscriptconns: RBXScriptConnection,
}

export type ControllerModule = {
	new: (ac130: Model) -> ControllerInstance,
}

return {}
