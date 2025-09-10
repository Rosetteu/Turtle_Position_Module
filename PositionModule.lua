local position = {}
local positionFile = "position"

assert(writeFile, "writeFile() is nil.")
assert(readFile, "readFile() is nil.")


function position.set(x, y, z, face)
    local CurrentPosition = readFile(positionFile)
    if type(x) == "table" then
        TurtlePosition = {
            x = x.x or 0,
            y = x.y or 0,
            z = x.z or 0,
            face = x.face or "north"
        }
    else
        TurtlePosition = {
            x = x or CurrentPosition.x or 0,
            y = y or CurrentPosition.y or 0,
            z = z or CurrentPosition.z or 0,
            face = face or CurrentPosition.face or "north"
        }
    end
    writeFile(positionFile, TurtlePosition)
end

function position.get()
    local TurtlePosition = readFile(positionFile)
    if not TurtlePosition then error("position.get à été utilisé alors que la position n'a pas été définie.") end
    return TurtlePosition
end

function position.forward()
    local TurtlePosition = position.get()
    if not TurtlePosition then error("TurtlePosition is nil.") end
    local HasBlock, datas = turtle.inspect()
    if HasBlock then
        return false, "Block", datas
    else
        if turtle.getFuelLevel() > 0 then
            local success = turtle.forward()
            if success then
                if TurtlePosition.face == "north" then
                    TurtlePosition.z = TurtlePosition.z - 1
                elseif TurtlePosition.face == "south" then
                    TurtlePosition.z = TurtlePosition.z + 1
                elseif TurtlePosition.face == "east" then
                    TurtlePosition.x = TurtlePosition.x + 1
                elseif TurtlePosition.face == "west" then
                    TurtlePosition.x = TurtlePosition.x - 1
                end
                position.set(TurtlePosition)
                return true
            else
                return false, "Unknown"
            end
        else
            return false, "No fuel"
        end
    end
end

function position.turnRight()
    local TurtlePosition = position.get()
    if not TurtlePosition then error("TurtlePosition is nil.") end
    local success = turtle.turnRight()
    if success then
        if TurtlePosition.face == "north" then
            TurtlePosition.face = "east"
        elseif TurtlePosition.face == "east" then
            TurtlePosition.face = "south"
        elseif TurtlePosition.face == "south" then
            TurtlePosition.face = "west"
        elseif TurtlePosition.face == "west" then
            TurtlePosition.face = "north"
        end
        position.set(TurtlePosition)
        return true
    else
        return false
    end
end

function position.turnLeft()
    local TurtlePosition = position.get()
    if not TurtlePosition then error("TurtlePosition is nil.") end
    local success = turtle.turnLeft()
    if success then
        if TurtlePosition.face == "north" then
            TurtlePosition.face = "west"
        elseif TurtlePosition.face == "west" then
            TurtlePosition.face = "south"
        elseif TurtlePosition.face == "south" then
            TurtlePosition.face = "east"
        elseif TurtlePosition.face == "east" then
            TurtlePosition.face = "north"
        end
        position.set(TurtlePosition)
        return true
    else
        return false
    end
end

function position.turnToFace(face)
    if face ~= "north" and face ~= "south" and face ~= "east" and face ~= "west" then error("face isn't a face.") end
    if face == position.get().face then return true end
    repeat
        position.turnLeft()
    until position.get().face == face
    return true
end

function position.getDistanceBetween(pointA,pointB)
    assert(pointA,"pointA is nil.")
    assert(pointB,"pointB is nil.")
    if type(pointA) ~= "table" then
        error("pointA isn't a table")
    end if type(pointB) ~= "table" then
        error("pointB isn't a table")
    end
    pointA = { x = tonumber(pointA.x) or 0, y = pointA.y or 0, z = pointA.z or 0}
    pointB = { x = pointB.x or 0, y = pointB.y or 0, z = pointB.z or 0}
return math.sqrt((pointB.x-pointA.x)^2+(pointB.y-pointA.y)^2+(pointB.z-pointA.z)^2)
end

function position.comparePosition(A, B, isATest)
    if not isATest then error("This function is'nt usable.") end
    assert(A, "A is nil")
    assert(B, "B is nil")
    if type(A) ~= "table" then
        error("A isn't a table.")
    end
    if type(B) ~= "table" then
        error("B isn't a table.")
    end
    A = { x = A.x or 0, y = A.y or 0, z = A.z or 0, face = A.face or "north" }
    B = { x = B.x or 0, y = B.y or 0, z = B.z or 0, face = B.face or "north" }

    for key, value in pairs(A) do
        print(key)
        if not B[key] then
            print("falseeee")
            return false
        end
        if B[key] ~= value then
            print(B[key], value)
            return false
        end
    end
    return true
end

function position.goTo(x, y, z, face)
    print("call")
    assert(x, "x is nil, had to be a number or a table.")
    local goal
    if type(x) == "table" then
        goal = { x = tonumber(x.x) or 0, y = tonumber(x.y) or 0, z = tonumber(x.z) or 0, face = x.face or "north" }
    else
        goal = {
            x = tonumber(x) or 0,
            y = tonumber(y) or 0,
            z = tonumber(z) or 0,
            face = face or "north"
        }
    end
    print(textutils.serialise(goal))
    if position.get() == goal then
        return true
    end
    local TurtlePosition = position.get()
    while position.get().x > goal.x do
        position.turnToFace("west")
        local HasBlock, datas = turtle.inspect()
        if HasBlock then
            if find(turtleSettings.blackListedBlocks, datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local success, Err = turtle.dig()
            if not success then
                print(Err)
            end
        end
        local success, Err = position.forward()
        if not success then
            if Err == "Block" then
                local success, Err = turtle.dig()
                if not success then
                    print(Err)
                end
            end
        end
    end
    while position.get().x < goal.x do
        position.turnToFace("east")
        local HasBlock, datas = turtle.inspect()
        if HasBlock then
            if find(turtleSettings.blackListedBlocks, datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local success, Err = turtle.dig()
            if not success then
                print(Err)
            end
        end
        local success, err = position.forward()
        if not success then
            if err == "block" then
                local success, err = turtle.dig()
                if not success then
                    print(err)
                end
            end
        end
    end
    while position.get().z > goal.z do
        position.turnToFace("north")
        local hasBlock, datas = turtle.inspect()
        if hasBlock then
            if find(turtleSettings.blackListedBlocks, datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local success, err = turtle.dig()
            if not success then
                print(err)
            end
        end
        local success, err = position.forward()
        if not success then
            if err == "block" then
                local success, err = turtle.dig()
                if not success then
                    print(err)
                end
            end
        end
    end
    while position.get().z < goal.z do
        position.turnToFace("south")
        local hasBlock, datas = turtle.inspect()
        if hasBlock then
            if find(turtleSettings.blackListedBlocks, datas.name) then
                error("Blacklisted block in fornt of the turtle.")
            end
            local success, err = turtle.dig()
            if not success then
                print(err)
            end
        end
        local success, err = position.forward()
        if not success then
            if err == "block" then
                local success, err = turtle.dig()
                if not success then
                    print(err)
                end
            end
        end
    end
    if face then
        position.turnToFace(face)
    end
end

return position
