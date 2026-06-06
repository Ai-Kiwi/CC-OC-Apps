local args = ...

--stop player from closing progeam :P
os.pullEvent = os.pullEventRaw
verson = "1.6"

--repair menu
function SystemRepair()

end



function BlueScreen()
    ClearChat()
    term.getBackgroundColor(colors.blue)
    print(":(")
    print("Oog Bog Something went very wrong. please tell me about this so i can recode the whole code base to fix ONE LITTLE GOD DAM ERROR")
    answer = read()
end


--get if to boot into dev verson
function LoadPhoneVersonMode()
    settings.load("systemFiles/bootSettings")
    PhoneMode = settings.get("PhoneMode")
    settings.save("systemFiles/bootSettings")
    
    if (PhoneMode == nil) then 
        PhoneMode = "main" 
        settings.load("systemFiles/bootSettings")
        settings.set("PhoneMode", PhoneMode)
        settings.save("systemFiles/bootSettings")
        -- other mode is Dev
    end
    PhoneMode = tostring(PhoneMode)
end

--clear chat function
function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end

ClearChat()
print("press any key to continue")
os.sleep(0.1)
local event, key = os.pullEvent("key")
if key == keys.insert then
    ClearChat()
    print("TOASTER OS BIOS")
    print("1 : set boot mode")
    answer = read()
    if answer == "1" then
        print("1 : Main")
        print("2 : Dev")
        answer = read()
        if answer == "1" then
            settings.load("systemFiles/bootSettings")
            settings.set("PhoneMode", "main")
            settings.save("systemFiles/bootSettings")
        else
            settings.load("systemFiles/bootSettings")
            settings.set("PhoneMode", "Dev")
            settings.save("systemFiles/bootSettings")
        end
    end
end

LoadPhoneVersonMode()
verson = verson .. " " .. PhoneMode

print("dowloading from " .. PhoneMode .. " release")


function UpdateInstaller()
    --removes removes old file incase one is left
    print("dowloading new luancher")
    InstallProgeam("","https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/ToasterOS_Updater.lua","startup",false,true)
end



function DrawVerson(PartNumber) 
if PartNumber == 1 then
    hight = 19
    name = " Pocket"
else 
    hight = 13
    name = " NeuralLink"
end
term.setTextColor(colors.red)
term.setCursorPos(1,hight)
print(verson .. name)
term.setCursorPos(1,1)
term.setTextColor(colors.white)
end

--https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/Dev/OSFiles/ToasterOS_Updater.lua
function InstallProgeam(locastion,GithubURL,Name,DoApiLoad,ISGitHubUrl)
    
    if ISGitHubUrl then
        print("installing " .. Name .. " from github")
        local GithubFileLink = http.get(GithubURL)
        if GithubFileLink then
            github_file = GithubFileLink.readAll()
            GithubFileLink.close()
        else
            term.setTextColor(colors.red)
            print("error failed to dowload")
            os.sleep(3)
            BlueScreen()
        end
        if github_file then
            term.setTextColor(colors.green)
            print("dowloading now instlling")
            fs.delete(Name)
            local f = io.open(Name, "w")
            f:write(github_file)
            f:close()
        end
    else
        shell.run("pastebin get " .. GithubURL .. " " .. Name)
    end

    if not (locastion == "") then
        locastionExists = fs.isDir(locastion)
        if not locastionExists then
            fs.makeDir(locastion)
        end
        fs.delete(locastion .. "/" .. Name)
        fs.move(Name,locastion .. "/" .. Name)
    end
    if DoApiLoad then
        fs.delete(Name)
        os.loadAPI(locastion .. "/" .. Name)
    end
end

function ErrorMenu()
    ClearChat()
    term.setTextColor.blue()
    print("TOASTER OS RECOVERY")
    term.setTextColor.red()
    print("1 : start Os")
    print("2 : factory reset")
    print("3 : reinstall installer")
    print("4 : export data to disk")
end    

term.clear()
term.setCursorPos(1,1)
if pocket then
        --says verson in bottem left
        DrawVerson(1) 
        --says its updating
        term.setTextColor(colors.green)
        print("updating for you")
        --says installer verson
        term.setTextColor(colors.white)
        print("installer/updater verson" .. verson)
        --runs the update installer function
        UpdateInstaller()
        --installing needed apis

        
        ClearChat()
        DrawVerson(1)

        print("Installing API'S")
        InstallProgeam("systemFiles/systemAPIS","https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/apis/AiKiwiBankAPI.lua","AIKIWIBANKAPI",true,true)
        InstallProgeam("systemFiles/systemAPIS","5YWfPd8Z","surface",true,false)
        --boots os
        print("running core os")
        InstallProgeam("systemFiles","https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/ToasterOS_Core.lua","coreOs",false,true)
        shell.run("systemFiles/coreOs")
else
    neuralInterFaceModule = peripheral.find("neuralInterface") 
    if neuralInterFaceModule then
        --says verson in bottem left
        DrawVerson(2) 
        --says its updating
        term.setTextColor(colors.green)
        print("updating for you")
        --says installer verson
        term.setTextColor(colors.white)
        --updater
        UpdateInstaller()
        --boot os
        print("running core os")
        --
        InstallProgeam("systemFiles","https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/progeams/ToasterBrainImplants.lua","coreOS",false,true)
        shell.run("coreOS")
    else
        term.setTextColor(colors.red)
        BlueScreen("Sorry unsupported device")
    end
end
os.sleep(2)
BlueScreen("Unkown")
