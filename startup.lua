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
_G.find = function(Table, Value)
    if not Table then error("Table is nil or false") end
    if not Value then error("Value is nil or false") end
    for i, v in ipairs(Table) do
        if v == Value then
            return i
        end
    end
    return nil
end

_G.turtleSettings = require("TurtleSettings")
_G.position = require("PositionModule")
local turtlePosition = readFile("Position")
print("Position : "..TurtlePosition.x..","..TurtlePosition.y..", "..TurtlePosition.z..", "..TurtlePosition.Face)
print("Carburant : "..turtle.getFuelLevel().." ("..(turtle.getFuelLevel()/turtle.getFuelLimit())*100 .."%)")