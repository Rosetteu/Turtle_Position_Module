local log = {}

if not enum then _G.enum = {} end
if not enum.logType then _G.enum.logType = { debug = { name = "debug", level = 0 }, warn = { name = "warn", level = 1 }, error = { name = "error", level = 2 }, critical = { name = "critical", level = 3 }, unknown = { name = "debug", level = 4 } } end

local timestamp = tostring(os.epoch("utc"))
fs.open("./logs/"..timestamp..".log","w").close()

log.add = function(logType, message, fileName, shutdown)
    if not logType then logType = logType.unknown end
    if not message then message = "No message provided." end

    addLineToFile("./logs/"..timestamp..".log", tostring(os.clock()) .. " - " .. fileName .. " : [" .. string.upper(logType.name) .. "] | " .. tostring(message))

    if shutdown == nil then shutdown = true end

    if shutdown and logType.level > 1 then
        addLineToFile("./logs/"..timestamp..".log", tostring(os.clock()) .. " : [SYSTEM] | Turtle shutdown.")
        os.shutdown()
    end
end
