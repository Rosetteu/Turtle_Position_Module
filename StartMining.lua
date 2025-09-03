local Utils = require("Utils")
local StartLocation = Position.Get()
while true do
    local HasBlock, Datas = turtle.inspectUp()
    if HasBlock then
        if Utils.Table.Find(TurtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.digUp()
        end
    end
    HasBlock, Datas = turtle.inspectDown()
    if HasBlock then
        if Utils.Table.Find(TurtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.digDown()
        end
    end
    Position.Right()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if Utils.Table.Find(TurtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    Position.Left()
    Position.Left()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if Utils.Table.Find(TurtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    Position.Right()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if not Utils.Table.Find(TurtleSettings.BlackListedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    if turtle.getFuelLevel() >= tonumber(turtle.getFuelLimit()) * 0.10 then
            local Success, Err = Position.Forward()
            if not Success then
                print("hii ",Err)
            end
        else
            print('Je rentre !')
        end
end
