local startLocation = position.get()

while true do
    local hasBlock, datas = turtle.inspectDown()
    if not hasBlock then
        local slot = 1
        local succes
        while not hasBlock and slot < 16 do
            turtle.select(slot)
            succes = turtle.placeDown()
            hasBlock, datas = turtle.inspectDown()
            slot = slot + 1
        end
    end
    local hasBlock, datas = turtle.inspectUp()
    if hasBlock then
        if datas.name == "minecraft:water" then
            local slot = 1
            local succes
            while not hasBlock and slot < 16 do
                turtle.select(slot)
                succes = turtle.placeUp()
                hasBlock, datas = turtle.inspectUp()
                slot = slot + 1
            end
        end
        if not find(turtleSettings.blacklistedBlocks, datas.name) then
            turtle.digUp()
        end
    end
    local hasBlock, datas = turtle.inspect()
    if hasBlock then
        if datas.name == "minecraft:water" then
            local slot = 1
            local succes
            while not hasBlock and slot < 16 do
                turtle.select(slot)
                succes = turtle.placeUp()
                hasBlock, datas = turtle.inspectUp()
                slot = slot + 1
            end
        end
        if not find(turtleSettings.blacklistedBlocks, datas.name) then
            local success, err = turtle.dig()
            if not success then
                local success, err = turtle.forward()
                if not success then
                    log(error, "was block infront of "..datas.name)
                end
            end
        end
    end
    turtle.select(16)
    if turtle.getItemDetails() then
        position.goTo(turtleSettings.coordinates.chest)
    end
    if turtle.getFuelLevel() > position.getDistanceBetween(position.get(),turtleSettings.coordinates.home)  then
        local success, err = position.forward()
        if not success then
            if err then
                writeFile("[Error] - "..tostring(os.clock())," = Error at "..textutils.serialise(position.get()).." : "..err)
            end
        end
    else
        position.goTo(turtleSettings.coordinates.home)
    end
end
