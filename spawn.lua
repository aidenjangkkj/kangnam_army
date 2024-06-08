-- 스크립트에서 생성할 적의 모델 이름을 지정합니다.
local ThisModel = "Enemy_Sniper"

-- 현재 스크립트가 위치한 파트의 위치를 변수에 저장합니다.
local part = script.Parent.Position

-- 히트박스 파트의 위치를 변수에 저장합니다.
local HitBoxPart = script.Parent.Parent.HitBox

-- 적이 스폰되는 것을 방지하기 위한 디바운스 변수입니다.
local Debounce = true

-- 스폰 시간을 저장하는 변수입니다.
local SpawnTime = game.Workspace.SpawnTimer.Value

-- 적 NPC를 스폰하는 함수입니다.
local function SpawnNPC(otherPart)
    -- 디바운스가 true이고 충돌한 파트가 "Configuration" 객체를 가지고 있는 경우에만 실행됩니다.
    if Debounce and otherPart.Parent:FindFirstChildWhichIsA("Configuration") then
        -- 디바운스를 false로 설정하여 추가 스폰을 방지합니다.
        Debounce = false

        -- ReplicatedStorage의 EnemyContainer에서 ThisModel에 해당하는 적 모델을 찾습니다.
        local Find = game:GetService("ReplicatedStorage")["EnemyContainer"]:FindFirstChild(ThisModel)
        if Find then
            -- 찾은 모델을 복제하여 작업공간에 추가합니다.
            local Clone = Find:Clone()
            Clone.Parent = game:GetService("Workspace")
            Clone:MakeJoints() -- 클론의 조인트를 만듭니다.
            Clone:MoveTo(part) -- 클론을 지정된 위치로 이동시킵니다.
            print("Spawned!") -- 스폰 완료 메시지를 출력합니다.
            
            -- 스폰 시간을 대기합니다.
            wait(SpawnTime)
            
            -- 디바운스를 true로 설정하여 다음 스폰을 허용합니다.
            Debounce = true
            print("Timer has ended!") -- 타이머 종료 메시지를 출력합니다.
        end
    end
end

-- 히트박스 파트에 충돌 이벤트가 발생하면 SpawnNPC 함수를 호출합니다.
HitBoxPart.Touched:Connect(SpawnNPC)
