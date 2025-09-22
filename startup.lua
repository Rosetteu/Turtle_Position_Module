_G.readFile = function (FileName)
    if not FileName then error("FileName is nil") end
    local File = fs.open(FileName,"r")
    local Data = textutils.unserialiseJSON(File.readAll())
    File.close()
    return Data
end
_G.writeFile = function (FileName, Data)
    assert(FileName,"FileName is nil")
    assert(Data,"Data is nil.")

    local File = fs.open(FileName,"w")
    File.write(textutils.serialiseJSON(Data))
    File.close()
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
_G.log = function(logType, messages, fileName)
    if not logType then logType = "unknown" end
    if not message then message = "No message provided." end
    if fileName and fileName ~= "" then 
        writeFile(fileName.." - "..tostring(os.clock()),"[logType] | "..message)
    else
        writeFile(tostring(os.clock()),"[logType] | "..message)
    end
end

_G.turtleSettings = require("TurtleSettings")
_G.position = require("PositionModule")
local turtlePosition = readFile("Position")
print("Position : "..turtlePosition.x..","..turtlePosition.y..", "..turtlePosition.z..", "..turtlePosition.face)
print("Carburant : "..turtle.getFuelLevel().." ("..(turtle.getFuelLevel()/turtle.getFuelLimit())*100 .."%)")