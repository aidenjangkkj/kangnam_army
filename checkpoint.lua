-- Players 서비스에서 플레이어 정보를 가져옵니다.
local Players = game:GetService("Players")

-- ServerStorage 서비스에서 서버 저장소를 가져옵니다.
local ServerStorage = game:GetService("ServerStorage")

-- 체크포인트 객체를 변수에 저장합니다.
local checkpoint = script.Parent

-- 체크포인트가 터치되었을 때 실행되는 함수입니다.
function onTouched(hit)
	-- 충돌한 객체가 유효하고, 해당 객체의 부모에 Humanoid 객체가 있는지 확인합니다.
	if hit and hit.Parent and hit.Parent:FindFirstChildOfClass("Humanoid") then
		-- 플레이어 객체를 가져옵니다.
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		
		-- ServerStorage에서 CheckpointData 폴더를 찾습니다.
		local checkpointData = ServerStorage:FindFirstChild("CheckpointData")
		
		-- CheckpointData 폴더가 없으면 새로 생성합니다.
		if not checkpointData then
			checkpointData = Instance.new("Folder")
			checkpointData.Name = "CheckpointData"
			checkpointData.Parent = ServerStorage
		end
		
		-- 플레이어의 UserId를 문자열로 변환합니다.
		local userIdString = tostring(player.UserId)
		
		-- CheckpointData 폴더에서 플레이어의 체크포인트 값을 찾습니다.
		local checkpointValue = checkpointData:FindFirstChild(userIdString)
		
		-- 체크포인트 값이 없으면 새로 생성합니다.
		if not checkpointValue then
			checkpointValue = Instance.new("ObjectValue")
			checkpointValue.Name = userIdString
			checkpointValue.Parent = checkpointData
			
			-- 플레이어의 캐릭터가 새로 추가될 때의 동작을 설정합니다.
			player.CharacterAdded:connect(function(character)
				wait() -- 캐릭터가 완전히 로드될 때까지 잠시 대기합니다.
				
				-- 저장된 체크포인트 위치로 캐릭터를 이동시킵니다.
				local storedCheckpoint = ServerStorage.CheckpointData[userIdString].Value
				character:MoveTo(storedCheckpoint.Position + Vector3.new(math.random(-4, 4), 4, math.random(-4, 4)))
			end)
		end
		
		-- 체크포인트 값을 현재 체크포인트로 설정합니다.
		checkpointValue.Value = checkpoint
	end
end

-- 체크포인트가 터치되었을 때 onTouched 함수를 연결합니다.
checkpoint.Touched:Connect(onTouched)
