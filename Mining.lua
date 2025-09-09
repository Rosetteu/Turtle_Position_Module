local StartLocation = position.Get()

while true do
    local HasBlock, Datas = turtle.inspectUp()
    if HasBlock then
        if find(turtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.digUp()
        end
    end
    HasBlock, Datas = turtle.inspectDown()
    if HasBlock then
        if find(turtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.digDown()
        end
    end
    position.Right()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if find(turtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    position.Left()
    position.Left()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if find(turtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    position.Right()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if not find(turtleSettings.BlackListedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    if turtle.getFuelLevel() >= tonumber(turtle.getFuelLimit()) * 0.10 then
            local Success, Err = position.Forward()
            if not Success then
                print("hii ",Err)
            end
        else
            print('Je rentre !')
        end
end
