term.clear()
local DevMode = false
if DevMode == true then
    --starts with auto updates on
    shell.run("KiwiOS/startup.lua false")
else
    shell.run("KiwiOS/startup.lua true")
end
