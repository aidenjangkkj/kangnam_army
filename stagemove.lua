-- ReplicatedStorage 서비스에서 복제 저장소를 가져옵니다.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Players 서비스에서 플레이어 정보를 가져옵니다.
local Players = game:GetService("Players")

-- 새로운 BindableEvent 객체를 생성하여 "EnemyKilled"라는 이름을 지정합니다.
local nextStageTrigger = Instance.new("BindableEvent")
nextStageTrigger.Name = "EnemyKilled"
nextStageTrigger.Parent = ReplicatedStorage

-- 적이 죽었을 때 호출되는 함수입니다.
local function onEnemyKilled()
	-- 모든 플레이어를 다음 스테이지로 이동시키는 로직입니다.
	for _, player in pairs(Players:GetPlayers()) do
		local character = player.Character
		if character then
			-- 다음 스테이지의 스폰 위치를 찾습니다.
			local nextStageSpawn = workspace:FindFirstChild("Checkpoint")
			if nextStageSpawn then
				wait(5) -- 5초 대기 후에 플레이어를 이동시킵니다.
				character:SetPrimaryPartCFrame(nextStageSpawn.CFrame) -- 플레이어 캐릭터를 다음 스테이지의 체크포인트로 이동시킵니다.
				game.Lighting.ClockTime = 18 -- 게임의 조명 시간을 오후 6시로 설정합니다.
			end
		end
	end
end

-- "EnemyKilled" 이벤트가 발생했을 때 onEnemyKilled 함수를 연결합니다.
ReplicatedStorage.EnemyKilled.Event:Connect(onEnemyKilled)
