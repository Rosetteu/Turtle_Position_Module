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
    if turtle.getFuelLevel() > position.getDistanceBetween(position.get(),turtleSettings.Home)  then
        local success, err = position.Forward()
        if not success then
        end
    end
end
