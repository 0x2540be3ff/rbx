self.TacticalReloadAnim = function(objs)
	TS:Create(objs[1], TweenInfo.new(.25,Enum.EasingStyle.Sine), {C1 = (CFrame.new(0.05,-0.15,1) * CFrame.Angles(math.rad(110),math.rad(-15),math.rad(0))):inverse() }):Play()
	TS:Create(objs[2], TweenInfo.new(.5,Enum.EasingStyle.Back), {C1 = (CFrame.new(-.75,-0.15,.5) * CFrame.Angles(math.rad(60),math.rad(-5),math.rad(15))):inverse() }):Play()
	wait(.3)

	TS:Create(objs[1], TweenInfo.new(.5,Enum.EasingStyle.Back), {C1 = (CFrame.new(0.05,-0.15,1) * CFrame.Angles(math.rad(100),math.rad(-5),math.rad(0))):inverse() }):Play()
	wait(.05)
	objs[4].Handle.MagOut:Play()
	objs[4].Mag.Transparency = 1

	local FakeMag = objs[4]:WaitForChild("Mag"):Clone()
	FakeMag:ClearAllChildren()
	FakeMag.Transparency = 0
	FakeMag.Parent = objs[4]
	FakeMag.Anchored = false
	FakeMag.CanCollide = true
	FakeMag.RotVelocity = Vector3.new(0,0,0)
	FakeMag.Velocity = (FakeMag.CFrame.UpVector * 5)
	FakeMag.Parent = game.Workspace

	wait(.5)
	objs[4].Handle.AimUp:Play()
	wait(.25)
	TS:Create(objs[2], TweenInfo.new(.3,Enum.EasingStyle.Sine), {C1 = (CFrame.new(-.75,-0.5,.25) * CFrame.Angles(math.rad(110),math.rad(-15),math.rad(30))):inverse() }):Play()
	wait(.25)
	objs[4].Handle.MagIn:Play()
	TS:Create(objs[1], TweenInfo.new(.15,Enum.EasingStyle.Sine), {C1 = (CFrame.new(0.05,-0.15,1) * CFrame.Angles(math.rad(101),math.rad(-6),math.rad(0))):inverse() }):Play()
	objs[4].Mag.Transparency = 0
	wait(.2)
	TS:Create(objs[2], TweenInfo.new(.15,Enum.EasingStyle.Sine), {C1 = (CFrame.new(-.75,-0.5,.25) * CFrame.Angles(math.rad(60),math.rad(-15),math.rad(30))):inverse() }):Play()
	wait(.25)
	TS:Create(objs[2], TweenInfo.new(.1,Enum.EasingStyle.Sine), {C1 = (CFrame.new(-.75,-0.5,.25) * CFrame.Angles(math.rad(100),math.rad(-15),math.rad(30))):inverse() }):Play()
	wait(.05)
	TS:Create(objs[1], TweenInfo.new(.1,Enum.EasingStyle.Sine), {C1 = (CFrame.new(0.05,-0.15,1) * CFrame.Angles(math.rad(105),math.rad(-5),math.rad(0))):inverse() }):Play()
	wait(.15)
	TS:Create(objs[1], TweenInfo.new(.25,Enum.EasingStyle.Sine), {C1 = (CFrame.new(0.05,-0.15,1) * CFrame.Angles(math.rad(90),math.rad(0),math.rad(0))):inverse() }):Play()
	TS:Create(objs[2], TweenInfo.new(.25,Enum.EasingStyle.Sine), {C1 = (CFrame.new(-.85,0.05,.6) * CFrame.Angles(math.rad(110),math.rad(-15),math.rad(25))):inverse() }):Play()
	wait(.25)
	objs[4].Bolt.SlideRelease:Play()
	TS:Create(objs[4].Handle.Slide, TweenInfo.new(.15,Enum.EasingStyle.Linear), {C0 =  CFrame.new():inverse() }):Play()
	TS:Create(objs[2], TweenInfo.new(.15,Enum.EasingStyle.Back), {C1 = (CFrame.new(-.8,0.05,.6) * CFrame.Angles(math.rad(110),math.rad(-15),math.rad(30))):inverse() }):Play()
	wait(.15)
end;
