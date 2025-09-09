local startLocation = position.Get()

while true do
    local hasBlock, datas = turtle.inspectUp()
    if hasBlock then
        if not find(turtleSettings.BlacklistedBlocks, datas.name) then
            turtle.digUp()
        end
    end
    hasBlock, datas = turtle.inspect()
    if hasBlock then
        if not find(turtleSettings.BlackListedBlocks, datas.name) then
            turtle.dig()
        end
    end
    if turtle.getFuelLevel() >= tonumber(turtle.getFuelLimit()) * 0.10 then
            local Success, Err = position.Forward()
            if not Success then
            end
        else
            print('Je rentre !')
        end
end
