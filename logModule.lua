local log = {}

local modem = peripheral.find("modem")
print("logModule | modem = " .. tostring(modem))
local debugChannel = turtleSettings.wirelessDebugChannel
if debugChannel == 0 or not modem then
    debugChannel = false
else
   modem.open(debugChanel)
end

if not enum then _G.enum = {} end
if not enum.logType then _G.enum.logType = { debug = { name = "debug", level = 0 }, warn = { name = "warn", level = 1 }, error = { name = "error", level = 2 }, critical = { name = "critical", level = 3 }, unknown = { name = "debug", level = 4 } } end

local timestamp = tostring(os.epoch("utc"))
fs.makeDir("./logs")
fs.open("./logs/" .. timestamp .. ".log", "w").close()

log.add = function(lType, message, fileName, forceShutdown)
    lType = lType or enum.logType.unknown
    message = message or "No message provided."
    fileName = fileName or "N/A"
    if forceShutdown == nil then forceShutdown = true end

    local timeStr = string.format("%.2f", os.clock())
    local line = timeStr .. " - " .. fileName .. " : [" .. string.upper(lType.name) .. "] | " .. tostring(message)

    if debugChanel and modem then 
        modem.transmit(debugChanel, 0, line) 
    end

    addLineToFile(logPath, line)

    if forceShutdown and lType.level > 1 then
        local shutdownMsg = timeStr .. " : [SYSTEM] | Turtle shutdown due to critical error."
        addLineToFile(logPath, shutdownMsg)
        if debugChanel and modem then modem.transmit(debugChanel, 0, shutdownMsg) end
        
        sleep(0.5)
        os.shutdown()
    end
end

return log