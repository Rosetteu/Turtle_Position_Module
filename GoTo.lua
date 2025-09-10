local Locations = {
    House = { Position = {x=0,y=-55,z=0}, Names = {"house","maison","home"}},
    Chest = { Position = {x=1,y=-55,z=-1}, Names = {"chest","coffre"}}
}

local Args = {...}
if #Args == 1 then
    local str = Args[1]
    if type(str) ~= "string" then return end
    for _, Location in pairs(Locations) do
        if find(Location.Names,string.lower(str)) then
            position.goTo(Location.Position)
        end
    end
else
    if #Args < 3 then
        print("3+ arguments needs, gave "..#Args)
        return
    end
    position.goTo(tonumber(Args[1]), tonumber(Args[2]), tonumber(Args[3]), Args[4])
end