_G.readFile = function (fileName)
    if not fileName then error("fileName is nil") end
    local file = fs.open(fileName,"r")
    local Data = textutils.unserialiseJSON(File.readAll())
    file.close()
    return Data
end
_G.writeFile = function (fileName, data)
    assert(fileName,"fileName is nil")
    assert(data,"data is nil.")

    local file = fs.open(fileName,"w")
    file.write(textutils.serialiseJSON(Data))
    file.close()
    return true
end
_G.addLineToFile = function (fileName, data)
    assert(fileName,"fileName is nil")
    assert(data,"data is nil.")

    local file = fs.open(fileName,"a")
    if not file then return false,"file"
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

_G.Enum = {
    LogType = {debug = "debug", warn = "warn", error = "error", critical = "critical", unknown = "unknown"}
}

_G.log = function(logType, messages, fileName)
    if not logType then logType = unknown end
    if not message then message = "No message provided." end
    if fileName and fileName ~= "" then 
        writeFile(fileName.." - "..tostring(os.clock()),"[logType] | "..message)
    else
        writeFile(tostring(os.clock()),"["..string.upper(logType).."] | "..message)
    end
end

_G.turtleSettings = require("TurtleSettings")
_G.position = require("PositionModule")
local turtlePosition = readFile("Position")
print("Position : "..turtlePosition.x..","..turtlePosition.y..", "..turtlePosition.z..", "..turtlePosition.face)
print("Carburant : "..turtle.getFuelLevel().." ("..(turtle.getFuelLevel()/turtle.getFuelLimit())*100 .."%)")