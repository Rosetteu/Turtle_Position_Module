local Locations = {
    House = { Position = {1,-55,-1}, Names = { "House","Maison","Home"}}
}

local Args = {...}
if #Args == 1 then
    local Str = Args[1]
    if not type(Str) == "string" then return end
    for _, Location in ipairs(Locations) do
        if Utils.Table.Find(Location.Names,Str) then
            Position.GoTo(Location.Position)
        end
    end
else
    if #Args < 3 then
        print("3+ arguments needs, gave "..#Args)
        return
    end
    Position.GoTo(Args[1], Args[2], Args[3], Args[4])
end