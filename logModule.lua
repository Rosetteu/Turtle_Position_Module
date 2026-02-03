if not enum then _G.enum = {} end
if not enum.logType then _G.enum.logType = { debug = { name = "debug", level = 0 }, warn = { name = "warn", level = 1 }, error = { name = "error", level = 2 }, critical = { name = "critical", level = 3 }, unknown = { name = "debug", level = 4 } } end


_G.logType = enum.logType

_G.log = function(lType, message, fileName, immediatelyCut)
    if not lType then lType = logType.unknown end
    if not message then message = "No message provided." end
    addLineToFile("log",
        tostring(os.clock()) .. " - " .. fileName .. " : [" .. string.upper(lType.name) .. "] | " .. tostring(message))
    if immediatelyCut == nil then immediatelyCut = true end
    if immediatelyCut and lType.level > 1 then
        addLineToFile("log", tostring(os.clock()) .. " : [SYSTEM] | Turtle shutdown.")
        os.shutdown()
    end
end
