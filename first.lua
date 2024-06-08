local Players = game:GetService("Players")

-- 플레이어가 처음 게임에 들어올 때 호출되는 함수
local function onPlayerAdded(player)
	player.CharacterAdded:Connect(function(character)
		-- 스폰 위치 설정
		local initialSpawn = workspace:FindFirstChild("InitialSpawn")
		if initialSpawn then
			character:SetPrimaryPartCFrame(initialSpawn.CFrame)
		end

		-- 캐릭터 초기 상태 설정
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.Health = humanoid.MaxHealth  -- 캐릭터의 체력을 최대 체력으로 설정
			humanoid.WalkSpeed = 16  -- 캐릭터의 걷기 속도 설정

			-- 캐릭터의 특정 부위를 기울이지 않고 직선으로 설정
			local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
			if torso then
				torso.CFrame = torso.CFrame - Vector3.new(0, torso.Size.Y/2, 0)  -- 머리를 위로 들어올리고 다리를 아래로 내림
			end
		end
	end)
end

-- 모든 기존 플레이어 및 이후 추가될 플레이어에 대해 onPlayerAdded 함수 연결
for _, player in pairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)
