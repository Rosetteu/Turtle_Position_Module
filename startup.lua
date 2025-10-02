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

_G.enum = {
    logType = {debug = {name="debug",level=0}, warn = {name="warn",level=1}, error = {name="error",level=2}, critical = {name="critical",level=3}, unknown = {name="debug",level=4}}
}

_G.logType = enum.logType

_G.log = function(lType, messages, fileName, immediatelyCut?)
    if not lType then lType = logType.unknown end
    if not message then message = "No message provided." end
    addLineToFile("log", tostring(os.clock()).." - "..fileName.." : ["..string.upper(lType.name).."] | "..tostring(message))
    if immediatelyCut == nil then immediatelyCut = true end
    if immediatelyCut and lType.level > 1 then
        addLineToFile("log",tostring(os.clock()).." : [SYSTEM] | Turtle shutdown.")
        turtle.shutdown()
    end
end

_G.turtleSettings = require("TurtleSettings")
_G.position = require("PositionModule")
local turtlePosition = readFile("Position")
print("Position : "..turtlePosition.x..","..turtlePosition.y..", "..turtlePosition.z..", "..turtlePosition.face)
print("Carburant : "..turtle.getFuelLevel().." ("..(turtle.getFuelLevel()/turtle.getFuelLimit())*100 .."%)")