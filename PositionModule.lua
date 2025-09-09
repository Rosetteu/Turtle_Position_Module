local Position = {}
local PositionFile = "Position"

function Position.Set(x, y, z, Face)
    local CurrentPosition = ReadFile(PositionFile)
    if type(x) == "table" then
        TurtlePosition = {
            x = x.x or 0,
            y = x.y or 0,
            z = x.z or 0,
            Face = x.Face or "north"
        }
    else
        TurtlePosition = {
            x = x or CurrentPosition.x or 0,
            y = y or CurrentPosition.y or 0,
            z = z or CurrentPosition.z or 0,
            Face = Face or CurrentPosition.Face or "north"
        }
    end
    WriteFile(PositionFile, TurtlePosition)
end


function Position.Get()
    local TurtlePosition = ReadFile(PositionFile)
    if not TurtlePosition then error("Position.Get à été utilisé alors que la position n'a pas été définie.") end
    return TurtlePosition
end

function Position.Forward()
    local TurtlePosition = Position.Get()
    if not TurtlePosition then error("TurtlePosition is nil.") end
    local HasBlock, Datas = turtle.inspect()
    if HasBlock then
        return false,"Block",Datas
    else
        if turtle.getFuelLevel() > 0 then
            local Success = turtle.forward()
            if Success then
                if TurtlePosition.Face == "north" then
                    TurtlePosition.z = TurtlePosition.z - 1
                elseif TurtlePosition.Face == "south" then
                    TurtlePosition.z = TurtlePosition.z+ 1
                elseif TurtlePosition.Face == "east" then
                    TurtlePosition.x = TurtlePosition.x + 1
                elseif TurtlePosition.Face == "west" then
                    TurtlePosition.x = TurtlePosition.x - 1
                end
                Position.Set(TurtlePosition)
                return true
            else
                return false, "Unknown"
            end
        else
            return false, "No fuel"
        end
    end
end

function Position.Right()
    local TurtlePosition = Position.Get()
    if not TurtlePosition then error("TurtlePosition is nil.") end
    local Success = turtle.turnRight()
    if Success then
        if TurtlePosition.Face == "north" then
            TurtlePosition.Face = "east"
        elseif TurtlePosition.Face == "east" then
            TurtlePosition.Face = "south"
        elseif TurtlePosition.Face == "south" then
            TurtlePosition.Face = "west"
        elseif TurtlePosition.Face == "west" then
            TurtlePosition.Face = "north"
        end
        Position.Set(TurtlePosition)
        return true
    else
        return false
    end
end

function Position.Left()
    local TurtlePosition = Position.Get()
    if not TurtlePosition then error("TurtlePosition is nil.") end
    local Success = turtle.turnLeft()
    if Success then
        if TurtlePosition.Face == "north" then
            TurtlePosition.Face = "west"
        elseif TurtlePosition.Face == "west" then
            TurtlePosition.Face = "south"
        elseif TurtlePosition.Face == "south" then
            TurtlePosition.Face = "east"
        elseif TurtlePosition.Face == "east" then
            TurtlePosition.Face = "north"
        end
        Position.Set(TurtlePosition)
        return true
    else
        return false
    end
end

function Position.TurnToFace(Face) 
    if Face ~= "north" and Face ~= "south" and Face ~= "east" and Face ~= "west" then error("Face isn't a face.") end
    if Face == Position.Get().Face then return true end
    repeat
        Position.Left()
    until Position.Get().Face == Face
    return true
end

--[[
function ComparePosition(A,B)
    assert(A,"A is nil")
    assert(B,"B is nil")
    if type(A) ~= "table" then
        error("A is'n a table.")
    end
    if type(B) ~= "table" then
        error("B is'n a table.")
    end
    A = {x=A.x or 0,y=A.y or 0,z=A.z or 0,Face=A.Face or "north"}
    B = {x=B.x or 0,y=B.y or 0,z=B.z or 0,Face=B.Face or "north"}
    for key, Value in pairs(A) do
        print(key)
        if not B[key] then print("falseeee") return false end
        if B[key] ~= Value then 
            print(B[key],Value)
            return false
        end
    end
    return true
end]]

function Position.GoTo(x,y,z,Face)
    assert(x,"x is nil, had to be a number or a table.")
    local Goal
    if type(x) == "table" then
        Goal = {x=x.x or 0,y=x.y or 0,z=x.z or 0,Face=x.Face or "north"}
    else
        Goal = {
            x = x or 0,
            y = y or 0,
            z = z or 0,
            Face = Face or "north"
        }
    end
    if Position.Get() == Goal then
        return true
    end
    local TurtlePosition = Position.Get()
    while Position.Get().x > Goal.x do
        Position.TurnToFace("west")
        local HasBlock, Datas = turtle.inspect()
        if HasBlock then
            if Utils.Table.Find(TurtleSettings.BlackListedBlocks,Datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local Success, Err = turtle.dig()
            if not Success then
                print(Err)
            end
        end
        local Success, Err = Position.Forward()
        if not Success then
            if Err == "Block" then
                local Success, Err = turtle.dig()
                if not Success then
                    print(Err)
                end
            end
        end
    end
    while Position.Get().x < Goal.x do
        Position.TurnToFace("east")
        local HasBlock, Datas = turtle.inspect()
        if HasBlock then
            if Utils.Table.Find(TurtleSettings.BlackListedBlocks,Datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local Success, Err = turtle.dig()
            if not Success then
                print(Err)
            end
        end
        local Success, Err = Position.Forward()
        if not Success then
            if Err == "Block" then
                local Success, Err = turtle.dig()
                if not Success then
                    print(Err)
                end
            end
        end
    end
    while Position.Get().z > Goal.z do
        Position.TurnToFace("north")
        local HasBlock, Datas = turtle.inspect()
        if HasBlock then
            if Utils.Table.Find(TurtleSettings.BlackListedBlocks,Datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local Success, Err = turtle.dig()
            if not Success then
                print(Err)
            end
        end
        local Success, Err = Position.Forward()
        if not Success then
            if Err == "Block" then
                local Success, Err = turtle.dig()
                if not Success then
                    print(Err)
                end
            end
        end
    end
    while Position.Get().z < Goal.z do
        Position.TurnToFace("south")
        local HasBlock, Datas = turtle.inspect()
        if HasBlock then
            if Utils.Table.Find(TurtleSettings.BlackListedBlocks,Datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local Success, Err = turtle.dig()
            if not Success then
                print(Err)
            end
        end
        local Success, Err = Position.Forward()
        if not Success then
            if Err == "Block" then
                local Success, Err = turtle.dig()
                if not Success then
                    print(Err)
                end
            end
        end
    end
    if Face then
        Position.TurnToFace(Face)
    end
end

return Position