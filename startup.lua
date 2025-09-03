_G.ReadFile = function (FileName)
    if not FileName then error("FileName is nil") end
    local File = fs.open(FileName,"r")
    local Data = textutils.unserialiseJSON(File.readAll())
    File.close()
    return Data
end
_G.WriteFile = function (FileName, Data)
    assert(FileName,"FileName is nil")
    assert(Data,"Data is nil.")

    local File = fs.open(FileName,"w")
    File.write(textutils.serialiseJSON(Data))
    File.close()
    return true
end
_G.TurtleSettings = require("TurtleSettings")
_G.Utils = require("Utils")
_G.Position = require("PositionModule")
TurtlePosition = ReadFile("Position")
require("Reset")
print("Position : "..TurtlePosition.x..","..TurtlePosition.y..", "..TurtlePosition.z..", "..TurtlePosition.Face)
print("Carburant : "..turtle.getFuelLevel().." ("..(turtle.getFuelLevel()/turtle.getFuelLimit())*100 .."%)")