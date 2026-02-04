_G.readFile = function(fileName)
    if not fileName then error("fileName is nil") end
    local file = fs.open(fileName, "r")
    if not file then return false end
    local data = textutils.unserialiseJSON(file.readAll())
    file.close()
    return data
end

_G.writeFile = function(fileName, data)
    assert(fileName, "fileName is nil")
    assert(data, "data is nil.")

    local file = fs.open(fileName, "w")
    file.write(textutils.serialiseJSON(data))
    file.close()
    return true
end

_G.addLineToFile = function(fileName, data)
    assert(fileName, "fileName is nil")
    assert(data, "data is nil.")

    if type(data) == "table" then data = textutils.serialise(data) end

    local file = fs.open(fileName, "a")
    if not file then return false, "file" end
    file.writeLine(tostring(data))
    file.close()
    return true
end

_G.find = function(table, value)
    if not table or not value then return false end
    for i, v in ipairs(table) do
        if v == value then
            return i
        end
    end
    return nil
end


_G.turtleSettings = require("turtleSettings")
_G.log = require("logModule")
_G.position = require("positionModule")

term.clear()
term.setCursorPos(1, 1)

local turtlePosition = readFile("position.json")
if not turtlePosition then
    term.setTextColor(colors.orange)
    print("Undefined position, use setPosition to set turtle's position")
    term.setTextColor(colors.white)
else
    print("Position : " .. turtlePosition.x .. "," .. turtlePosition.y ..
    ", " .. turtlePosition.z .. ", " .. turtlePosition.face)
    print("Carburant : " .. turtle.getFuelLevel() .. " (" .. (turtle.getFuelLevel() / turtle.getFuelLimit()) * 100 ..
    "%)")
end

log.add(enum.logType.debug,"Turtle successfully start")
--log.add