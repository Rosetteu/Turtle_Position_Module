local StartLocation = Position.Get()
local find = function(Table, Value)
    if not Table then error("Table is nil or false") end
    if not Value then error("Value is nil or false") end
    for i, v in ipairs(Table) do
        if v == Value then
            return i
        end
    end
    return nil
end
while true do
    local HasBlock, Datas = turtle.inspectUp()
    if HasBlock then
        if find(TurtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.digUp()
        end
    end
    HasBlock, Datas = turtle.inspectDown()
    if HasBlock then
        if find(TurtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.digDown()
        end
    end
    Position.Right()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if find(TurtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    Position.Left()
    Position.Left()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if find(TurtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    Position.Right()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if not find(TurtleSettings.BlackListedBlocks, Datas.name) then
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
