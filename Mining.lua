local StartLocation = position.get()

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
    position.right()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if find(turtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    position.left()
    position.left()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if find(turtleSettings.WhitelistedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    position.right()
    HasBlock, Datas = turtle.inspect()
    if HasBlock then
        if not find(turtleSettings.BlackListedBlocks, Datas.name) then
            turtle.dig()
        end
    end
    if turtle.getFuelLevel() >= tonumber(turtle.getFuelLimit()) * 0.10 then
            local Success, Err = position.forward()
            if not Success then
                print("hii ",Err)
            end
        else
            print('Je rentre !')
        end
end
