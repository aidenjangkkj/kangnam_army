local teleportPad = script.Parent  -- 발판의 부모 객체
local teleportPosition = Vector3.new(1.629, -122.733, -2619.999)  -- 이동할 좌표 설정 (예: (0, 10, 0))

-- 캐릭터가 발판을 밟았을 때 호출되는 함수
local function onTouched(otherPart)
	local character = otherPart.Parent  -- 발판을 밟은 객체의 부모를 가져옴
	local humanoid = character:FindFirstChildOfClass("Humanoid")  -- 캐릭터가 사람형 객체인지 확인

	if humanoid then
		character:SetPrimaryPartCFrame(CFrame.new(teleportPosition))  -- 캐릭터의 위치를 설정된 좌표로 이동
		
	end
end

-- 발판에 터치 이벤트 연결
teleportPad.Touched:Connect(onTouched)
