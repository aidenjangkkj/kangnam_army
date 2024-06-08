-- Players 서비스에서 플레이어 정보를 가져옵니다.
local Players = game:GetService("Players")

-- 데미지를 입지 않은 후 체력을 회복하기까지의 대기 시간을 설정합니다 (초 단위).
local REGEN_DELAY = 5

-- 회복되는 체력의 양을 설정합니다.
local REGEN_RATE = 30

-- 플레이어의 체력 회복을 설정하는 함수입니다.
local function setupPlayer(player)
	-- 플레이어의 캐릭터를 가져오거나 캐릭터가 생성될 때까지 기다립니다.
	local character = player.Character or player.CharacterAdded:Wait()
	
	-- 캐릭터의 Humanoid 객체를 가져옵니다.
	local humanoid = character:WaitForChild("Humanoid")

	-- 마지막으로 데미지를 입은 시간을 저장하는 변수입니다.
	local lastDamageTime = tick()

	-- 체력 변화 이벤트를 연결합니다.
	humanoid.HealthChanged:Connect(function(health)
		-- 체력이 최대 체력보다 적으면 마지막 데미지 시간을 갱신합니다.
		if health < humanoid.MaxHealth then
			lastDamageTime = tick()
		end
	end)

	-- 무한 루프를 통해 체력을 회복하는 로직을 실행합니다.
	while true do
		wait(1) -- 1초마다 체크합니다.
		
		-- 마지막 데미지 이후 REGEN_DELAY 만큼 시간이 지났는지 확인합니다.
		if tick() - lastDamageTime >= REGEN_DELAY then
			-- 체력이 최대 체력보다 적으면 회복시킵니다.
			if humanoid.Health < humanoid.MaxHealth then
				humanoid.Health = math.min(humanoid.Health + REGEN_RATE, humanoid.MaxHealth)
			end
		end
	end
end

-- 새로운 플레이어가 추가될 때 setupPlayer 함수를 호출합니다.
Players.PlayerAdded:Connect(function(player)
	-- 플레이어의 캐릭터가 추가될 때 setupPlayer 함수를 호출합니다.
	player.CharacterAdded:Connect(function()
		setupPlayer(player)
	end)
end)

-- 현재 게임에 있는 모든 플레이어에 대해 setupPlayer 함수를 호출합니다.
for _, player in ipairs(Players:GetPlayers()) do
	-- 플레이어의 캐릭터가 이미 존재하는 경우 바로 setupPlayer 함수를 호출합니다.
	if player.Character then
		setupPlayer(player)
	else
		-- 플레이어의 캐릭터가 추가될 때 setupPlayer 함수를 호출합니다.
		player.CharacterAdded:Connect(function()
			setupPlayer(player)
		end)
	end
end
