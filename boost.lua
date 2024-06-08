-- 현재 스크립트가 위치한 객체를 변수에 저장합니다.
local walkSpeed = script.Parent

-- 터치 트리거 함수 정의
function touchTrigger(otherPart)
	-- 터치된 객체의 이름을 출력합니다.
	print("Triggered by:", otherPart.Name)
	
	-- 터치된 객체의 부모를 가져옵니다.
	local character = otherPart.Parent
	
	-- 부모가 존재하면 캐릭터의 이름을 출력합니다.
	if character then
		print("Character detected:", character.Name)
	end

	-- 부모 객체에서 Humanoid 클래스를 찾습니다.
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	-- Humanoid가 존재하면 현재 WalkSpeed를 출력합니다.
	if humanoid then
		print("Humanoid found with WalkSpeed:", humanoid.WalkSpeed)
	end

	-- Humanoid가 존재하고 WalkSpeed가 16 이하이면 WalkSpeed를 48로 설정합니다.
	if humanoid and humanoid.WalkSpeed <= 16 then
		humanoid.WalkSpeed = 48
		print("WalkSpeed set to 48") -- 주석 달기 전에는 32로 잘못된 출력 메시지가 있었습니다.
	end
end

-- 터치 이벤트가 발생하면 touchTrigger 함수를 호출합니다.
walkSpeed.Touched:Connect(touchTrigger)
