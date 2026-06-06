local function DownloadFile(FilePath,URL) 
    print("Downloading " .. URL .. " to " .. FilePath)

    --make sure path is a thing
    fs.makeDir(fs.getDir(FilePath))


    --save file
    local File = fs.open(FilePath,"w")
    if File == nil then
        error("Failed to download file")
    end
    local DownloadedFile = http.get(URL .. "?cb=" .. math.random(1,10000))
    if DownloadedFile == nil then
        error("Failed to save file")
    end
    File.write(DownloadedFile.readAll())
    File.close()
end

term.setBackgroundColor(colors.black)
term.setTextColor(colors.yellow)
print("Thank you for chosing KiwiOS")
print("please types \"yes\" to confirm you wanna install KiwiOS")
if (read() ~= "yes") then
    print("You have not typed \"yes\"")
    print("Exiting installer")
    error("",-1)
end
term.setTextColor(colors.white)
print("Installing...")
--on my todo list
--print("creating document folder...")
--fs.makeDir("/UserData/Documents/")
--print("moving all user data over to documents folder")
--local UserData = fs.list("/")
--for k,v in pairs(UserData) do
--    fs.move("/" .. v,"/UserData/Documents/" .. v)
--end


DownloadFile("KiwiOS/libs/bigfont.lua","https://raw.githubusercontent.com/Cheatoid/ComputerCraft-Cloud/main/typescript/Wojbie%20bigfont/out/bigfont.lua")
DownloadFile("KiwiOS/Update.lua","https://raw.githubusercontent.com/Ai-Kiwi/KiwiOS/main/KiwiOS/Update.lua")
print("running update")
shell.run("KiwiOS/Update.lua")
print("rebooting...")
os.reboot()

