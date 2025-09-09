local position = {}
local positionFile = "position"

assert(writeFile, "writeFile() is nil.")
assert(readFile, "readFile() is nil.")


function position.Set(x, y, z, Face)
    local CurrentPosition = readFile(positionFile)
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
    writeFile(positionFile, TurtlePosition)
end

function position.Get()
    local TurtlePosition = readFile(positionFile)
    if not TurtlePosition then error("position.Get à été utilisé alors que la position n'a pas été définie.") end
    return TurtlePosition
end

function position.Forward()
    local TurtlePosition = position.Get()
    if not TurtlePosition then error("TurtlePosition is nil.") end
    local HasBlock, Datas = turtle.inspect()
    if HasBlock then
        return false, "Block", Datas
    else
        if turtle.getFuelLevel() > 0 then
            local Success = turtle.forward()
            if Success then
                if TurtlePosition.Face == "north" then
                    TurtlePosition.z = TurtlePosition.z - 1
                elseif TurtlePosition.Face == "south" then
                    TurtlePosition.z = TurtlePosition.z + 1
                elseif TurtlePosition.Face == "east" then
                    TurtlePosition.x = TurtlePosition.x + 1
                elseif TurtlePosition.Face == "west" then
                    TurtlePosition.x = TurtlePosition.x - 1
                end
                position.Set(TurtlePosition)
                return true
            else
                return false, "Unknown"
            end
        else
            return false, "No fuel"
        end
    end
end

function position.Right()
    local TurtlePosition = position.Get()
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
        position.Set(TurtlePosition)
        return true
    else
        return false
    end
end

function position.Left()
    local TurtlePosition = position.Get()
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
        position.Set(TurtlePosition)
        return true
    else
        return false
    end
end

function position.TurnToFace(Face)
    if Face ~= "north" and Face ~= "south" and Face ~= "east" and Face ~= "west" then error("Face isn't a face.") end
    if Face == position.Get().Face then return true end
    repeat
        position.Left()
    until position.Get().Face == Face
    return true
end

function ComparePosition(A, B, isATest)
    if not isATest then error("This function is'nt usable.") end
    assert(A, "A is nil")
    assert(B, "B is nil")
    if type(A) ~= "table" then
        error("A isn't a table.")
    end
    if type(B) ~= "table" then
        error("B isn't a table.")
    end
    A = { x = A.x or 0, y = A.y or 0, z = A.z or 0, Face = A.Face or "north" }
    B = { x = B.x or 0, y = B.y or 0, z = B.z or 0, Face = B.Face or "north" }

    for key, Value in pairs(A) do
        print(key)
        if not B[key] then
            print("falseeee")
            return false
        end
        if B[key] ~= Value then
            print(B[key], Value)
            return false
        end
    end
    return true
end

function position.GoTo(x, y, z, Face)
    assert(x, "x is nil, had to be a number or a table.")
    local Goal
    if type(x) == "table" then
        Goal = { x = tonumber(x.x) or 0, y = tonumber(x.y) or 0, z = tonumber(x.z) or 0, Face = x.Face or "north" }
    else
        Goal = {
            x = tonumber(x) or 0,
            y = tonumber(y) or 0,
            z = tonumber(z) or 0,
            Face = Face or "north"
        }
    end
    if position.Get() == Goal then
        return true
    end
    local TurtlePosition = position.Get()
    while position.Get().x > Goal.x do
        position.TurnToFace("west")
        local HasBlock, Datas = turtle.inspect()
        if HasBlock then
            if find(turtleSettings.BlackListedBlocks, Datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local Success, Err = turtle.dig()
            if not Success then
                print(Err)
            end
        end
        local Success, Err = position.Forward()
        if not Success then
            if Err == "Block" then
                local Success, Err = turtle.dig()
                if not Success then
                    print(Err)
                end
            end
        end
    end
    while position.Get().x < Goal.x do
        position.TurnToFace("east")
        local HasBlock, Datas = turtle.inspect()
        if HasBlock then
            if find(turtleSettings.BlackListedBlocks, Datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local Success, Err = turtle.dig()
            if not Success then
                print(Err)
            end
        end
        local Success, Err = position.Forward()
        if not Success then
            if Err == "Block" then
                local Success, Err = turtle.dig()
                if not Success then
                    print(Err)
                end
            end
        end
    end
    while position.Get().z > Goal.z do
        position.TurnToFace("north")
        local HasBlock, Datas = turtle.inspect()
        if HasBlock then
            if find(turtleSettings.BlackListedBlocks, Datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local Success, Err = turtle.dig()
            if not Success then
                print(Err)
            end
        end
        local Success, Err = position.Forward()
        if not Success then
            if Err == "Block" then
                local Success, Err = turtle.dig()
                if not Success then
                    print(Err)
                end
            end
        end
    end
    while position.Get().z < Goal.z do
        position.TurnToFace("south")
        local HasBlock, Datas = turtle.inspect()
        if HasBlock then
            if find(turtleSettings.BlackListedBlocks, Datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local Success, Err = turtle.dig()
            if not Success then
                print(Err)
            end
        end
        local Success, Err = position.Forward()
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
        position.TurnToFace(Face)
    end
end

return position
