local bomb = script.Parent

local function explode()
	local explosionSound = bomb:FindFirstChild("ExplosionSound")
	if explosionSound then
		explosionSound:Play()
	end

	local explosion = Instance.new("Explosion")
	explosion.Position = bomb.Position
	explosion.BlastRadius = 10  
	explosion.BlastPressure = 500000  
	explosion.Parent = game.Workspace

	-- 폭발 피해 처리
	explosion.Hit:Connect(function(hitPart, distance)
		local character = hitPart.Parent
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:TakeDamage(50)  
		end
	end)

	bomb:Destroy()
end

bomb.Touched:Connect(function(hit)
	local character = hit.Parent
	if character:FindFirstChildOfClass("Humanoid") then
		explode()
	end
end)
