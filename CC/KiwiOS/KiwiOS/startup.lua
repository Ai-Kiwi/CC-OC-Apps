local args = {...}
local BigFont = require("libs.bigfont")
local MoniterX, MontierY = term.getSize()

local function LoadTextInMiddleOfScreen(TextToWrite,TextToWriteBelow)
    term.clear()
    --makes a noice start prompt using auto scaled text 
    


    local TextSizeX = #TextToWrite * 3
    local TextSizeY = 2

    term.setCursorPos(math.floor((MoniterX / 2) - (TextSizeX / 2)),math.floor((MontierY / 2) - (TextSizeY / 2)))

    BigFont.bigPrint(TextToWrite)
    if TextToWriteBelow then
        term.setCursorPos(math.floor((MoniterX / 2) - (#TextToWriteBelow / 2)),math.floor((MontierY / 2) + 1 + (TextSizeY / 2)))
        print(TextToWriteBelow)
    end
end

local function GetTextFromPercent(loadingPercent,TextSize,MaxSize)
    ASCII = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'. "
    local StartingText = ""
    for i=1, TextSize do
        if (i * MaxSize / TextSize) > loadingPercent then
            StartingText = StartingText .. "."
        else
            if ((i + 1) * MaxSize / TextSize) > loadingPercent then
                StartingText = StartingText .. ">"
            else
                StartingText = StartingText .. "-"
            end
        end

    end
    StartingText = StartingText .. " " .. math.floor((loadingPercent / MaxSize) * 100) .. "%"
    return StartingText
end



LoadTextInMiddleOfScreen("KiwiOS")
os.sleep(1)
LoadTextInMiddleOfScreen("KiwiOS","updating updater")
--download Update file
if args[1] == "true" then
    local UpdateFile = http.get("https://raw.githubusercontent.com/Ai-Kiwi/KiwiOS/main/KiwiOS/Update.lua" .. "?cb=" .. math.random(1,10000))
    if UpdateFile then
        local UpdateFileText = UpdateFile.readAll()
        UpdateFile.close()
        local UpdateFileFile = fs.open("KiwiOS/Update.lua","w")
        UpdateFileFile.write(UpdateFileText)
        UpdateFileFile.close()

        shell.run("KiwiOS/Update.lua")
    else
        LoadTextInMiddleOfScreen("KiwiOS","Update failed")
        os.sleep(1)
    end
end






shell.run("KiwiOS/kernil.lua")

if term.TrueNative == nil then
    term.TrueNative = term.native()
end
term.redirect(term.TrueNative)
term.setBackgroundColor(colors.red)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
BigFont.bigPrint(":(")

print("KiwiOS was unfortunately running to fast and smacked into a brick wall known as an error.")
print("")
print("Please report the following error to the developer")
print("<error code detection not yet installed>")

local TimeToRestart = 15
while true do
    term.setCursorPos(1,MontierY)
    term.clearLine()
    term.write("Restarting in " .. TimeToRestart .. " seconds")
    TimeToRestart = TimeToRestart - 1
    if TimeToRestart == 0 then
        os.reboot()
    end
    os.sleep(1)
end
