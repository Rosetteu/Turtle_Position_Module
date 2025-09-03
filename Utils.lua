local Utils = {
    Table = {
        Find = function(Table, Value)
            if not Table then error("Table is nil or false") end
            if not Value then error("Value is nil or false") end
            for i, v in ipairs(Table) do
                if v == Value then
                    return i
                end
            end
            return nil
        end
    }
}


return Utils