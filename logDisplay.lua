local modem = peripheral.find("modem")
print("logModule | modem = " .. tostring(modem))
local debugChannel = 69
if not modem then return end

modem.open(debugChanel)