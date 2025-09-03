local Args = {...}
if #Args == 1 then
    local Str = Args[1]
    if not type(Str) == "string" then return end
    if Str == "House" then
        Position.GoTo(1,-55,-1)
    end
end