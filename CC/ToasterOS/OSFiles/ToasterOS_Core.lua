changelogText = "moved everything over to github. fixed 2 bugs with musicOnTheGo and hopefully made it so it works with the headsets"
Verson = "0.6"



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

LoadPhoneVersonMode()
Verson = Verson .. " " .. PhoneMode

--stop player from closing progeam :P
os.pullEvent = os.pullEventRaw


function SaveSettings()
    settings.load("systemFiles/systemSettings")
    settings.set("NeuralInterfaceID", NeuralInterfaceID)
    settings.set("InstantBoot", InstantBoot)
    settings.save("systemFiles/systemSettings")
end


function LoadSettings()
settings.load("systemFiles/systemSettings")
NeuralInterfaceID = settings.get("NeuralInterfaceID")
InstantBoot = settings.get("InstantBoot")
settings.save("systemFiles/systemSettings")

if not NeuralInterfaceID then NeuralInterfaceID = 0 end
if not InstantBoot then InstantBoot = 0 end
InstantBootEnabled = tonumber(InstantBootEnabled)
NeuralInterfaceID = tonumber(NeuralInterfaceID)

MessageGogglesEnabled = false

end






--play sound script
function playSound(SoundUrl)
    if speaker == nil then
        data = {}
        data[1] = "play sound request"
        data[2] = SoundUrl
        data = textutils.serialize(data)
        NeuralInterfaceID = tonumber(NeuralInterfaceID)
        rednet.send(NeuralInterfaceID,data)
    else
        speaker.playSound(SoundUrl)
    end
end

--clear chat function
function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end


--cheek vaild phone function
function CheekId (ComputerIDCheek,PhoneList)
    for _, v in pairs (PhoneList) do
      if v == ComputerIDCheek then
        return true
      end
    end
    return false
end


function InstallProgeam(locastion,GithubURL,Name,DoApiLoad,ISGitHubUrl)
    fs.delete(Name)
    if ISGitHubUrl then
        print("installing " .. Name .. " from github")
        local GithubFileLink = http.get(GithubURL)
        if GithubFileLink then
            github_file = GithubFileLink.readAll()
        else
            print("error failed to dowload")
            os.sleep(5)
            BlueScreen()
        end
        GithubFileLink.close()
        local f = io.open(Name, "w")
        f:write(github_file)
        f:close()
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
        os.loadAPI(locastion .. "/" .. Name)
    end
end


function SetName()
if speaker == nil then
    soundText = ""
else
    soundText = "(Sound)"
end
if IsProPhones == true then
    PhoneName = "label set IToasterPro" .. soundText
else
    PhoneName = "label set IToasterBasic" .. soundText
end
    shell.run(PhoneName)
end

function CheekForButtenClick(MouseX,MouseY,ButtenStartX,ButtenStartY,ButtenEndX,ButtenEndY,NumberToReturn)
if MouseX > ButtenStartX and MouseX < ButtenEndX then
    if MouseY > ButtenStartY and MouseY < ButtenEndY then
        return NumberToReturn
    end
end
return 0
end


--brings up shutdown menu
function shutdownmenu()
    ClearChat()
    term.setTextColor(colors.white)
    print("what would you like todo?")
    print("1 restart")
    print("2 shutdown")
    print("3 back")
    answer = read()
    playSound(selectsound)
    if answer == "1" then
        os.reboot()
    elseif answer == "2" then
        os.shutdown()
    elseif answer == "3" then
        mainmenu()
    else
        shutdownmenu()
    end

end

--main menu
function mainmenu()
    local surf = surface.create(26, 20, " ", colors.orange, colors.white)
    
    --surf:drawText(1, 19, os.date("%d/%m/%Y %H:%M"))

    
     --surf:drawRect(3, 3, 11, 3, " ", colors.blue, colors.white)
     --surf:drawText(3, 3, "Progeams")

     term.setCursorPos(1,19)
     print(os.date("%d/%m/%Y %H:%M"))
     term.setCursorPos(1,1)
     term.setTextColor(colors.white)
     print("what would you like todo?")
     print("1 progeams")
     print("2 shutdown")
     print("3 settings")
     print("4 other")

    --surf:render(term)
    answer = read()
    playSound(selectsound)
    if IsDisplayPhone == true then
        answer = none
        term.setTextColor(colors.red)
        os.reboot()
    end
    if answer == "1" then
        progeamsmenu()
    elseif answer == "2" then
        shutdownmenu()
    elseif answer == "3" then
        settingsMenu()
    elseif answer == "4" then
        othermenu()
    else
        mainmenu()
    end
end

function settingsMenu()
    ClearChat()
    print("1: NeuralInterfaceID")
    print("2: Instant Boot")
    print("3: Save and exit")
    answer = read()
    playSound(selectsound)
    ClearChat()
    if answer == "1" then
        print("Chip ID?")
        answer = read()
        NeuralInterfaceID = answer
        settingsMenu()
    elseif answer == "2" then
        print("2: Instant Boot")
        print("1 : enabled")
        print("0 : disabled")
        answer = read()
        InstantBootEnabled = answer
        if answer == "0" then
            
            shell.run("pastebin get 5SaF0sQ4 TempStartup")
            shell.run("delete startup")
            shell.run("rename TempStartup startup")
        end
        settingsMenu()
    elseif answer == "3" then
        SaveSettings()
        LoadSettings()
        mainmenu()
    else
        settingsMenu()
    end
end



function progeamsmenu()
    ClearChat()
    print("1: MusicOnTheGo")
    print("2: Snake (built in)")
    print("3: TurtleLink")
    print("4: GPS")
    print("5: AiKiwiBank")
    print("6: ToastAmon")
    print("7: OneTube")
    print("8: back")
    answer = read()
    playSound(selectsound)
    if answer == "1" then
        RunProgeam("https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/progeams/MusicOnTheGo.lua","MusicOnTheGo",true)
    elseif answer == "2" then
        shell.run("worm")
        progeamsmenu()
    elseif answer == "3" then
        RunProgeam("https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/progeams/turtlelink.lua","TurtleLink",true)
    elseif answer == "4" then
        RunProgeam("https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/progeams/GPS.lua","GPS",true)
    elseif answer == "5" then
        RunProgeam("https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/progeams/AiKiwiBank.lua","AiKiwiBank",true)
    elseif answer == "6" then
        RunProgeam("https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/" .. PhoneMode .. "/OSFiles/progeams/ToastGo.lua","ToastAmon",true)
    elseif answer == "7" then
        RunProgeam("https://github.com/Ai-Kiwi/ToasterOS/blob/" .. PhoneMode .. "/OSFiles/progeams/WebStreaming.lua","OneTube",true)
    elseif answer == "8" then
        mainmenu()
    else
        progeamsmenu()
    end

end

function RunProgeam(PastebinURL,porgeamName,DOGITHUB)
    InstallProgeam("programs",PastebinURL,porgeamName,false,DOGITHUB)

    shell.run("fg " .. "programs/" .. porgeamName)
    GoodTimeToUpdate = true
    progeamsmenu()
end

function othermenu()
    ClearChat()
    term.setTextColor(colors.white)
    print("1 changelog")
    print("2 exit OS")
    print("3 Credits")
    print("4 back")
    answer = read()
    if IsDisplayPhone == true then
        answer = none
        term.setTextColor(colors.red)
        os.reboot()
    end
    if answer == "1" then
        ClearChat()
        print(changelogText)
        answer = read()
        othermenu()
    elseif answer == "2" then
        ClearChat()
        playSound(selectsound)
        if IsProPhones then
            ClearChat()
            term.setTextColor(colors.green)
            print("When you wanna go back into the os just run the command reboot")
            IsOSRunning = false
            answer = read()
            ClearChat()
            shell.exit()
        else
            ClearChat()
            term.setTextColor(colors.red)
            print("Look I'm sorry but you need pro")
            answer = read()
            othermenu()
        end
    elseif answer == "3" then
        ClearChat()
        term.setTextColor(colors.red)
        print("Creator")
        print("Ai Kiwi")
        print()
        term.setTextColor(colors.orange)
        print("beta Testers")
        print("KaleIsBean")
        print()
        print()
        print()
        print()
        print()
        print("this is 100% not a excuse to add this music into the software somewhere")
        playSound(CreditsMusic)
        answer = read()
        playSound(selectsound)
        othermenu()
    elseif answer == "4" then
        playSound(selectsound)
        mainmenu()
    else
        playSound(selectsound)
        othermenu()
    end
end

function GuiLoop()
    --loads settings
    LoadSettings()
    -- sets new name
    SetName()
    --says a nice os loaded text
    ClearChat()
    term.setTextColor(colors.green)
    --cheeks if its pro or basic for text
    if IsProPhones == true then
        term.setTextColor(colors.yellow)
        print("Toaster OS Pro loaded")
    else
        print("Toaster OS Basic loaded")
    end
    --prints contunie message
    print("enter to continue")

    term.setTextColor(colors.red)
    term.setCursorPos(1,3)
    if IsDisplayPhone then
        print("Display model")
    elseif speaker then
        print("Sound Modal")
    end



    --says verson
    term.setCursorPos(1,19)
    term.setTextColor(colors.white)
    print( "v".. Verson)
    playSound(bootsound)
    --says computer ID
    print("computer ID : " .. ComputerID)
    --waits for contuie
    term.setCursorPos(1,4)
    answer = read()
    playSound(selectsound)

    while IsOSRunning do
    mainmenu()
        if IsOSRunning then
            term.setTextColor(colors.red)
            print("press enter to contunie")
            answer = read()
            ClearChat()
            term.setTextColor(colors.red)
            print("error something has coused the phone to crash we have manged to fix the proleam. press enter to contunie")
            answer = read()
        end
    end
end    

function CheekForUpdates()

end

function LoadSetupOS()
    errorsound = "minecraft:block.anvil.land"
    bootsound = "minecraft:entity.player.levelup"
    selectsound = "minecraft:block.sand.break"
    CreditsMusic = "minecraft:music.credits"
    IsOSRunning = true
    DisplayPhones = {25}
    ProPhones = {9,10,14}
    ValidPhones = {1,3,9,10,11,15,24,25,32}
    --1 : for creative not owned by anyone
    --3 : a computer (look it was funny ok)
    --9 : my own phone (wireless) has admin powers
    --10 : coles wireless phone
    --11 : infernos phone (wireless)
    --15 : coles sound phone
    --24 : infernos phone (sound)
    --25 : display phone
    --32 : my sisters phone

    GoodTimeToUpdate = false
    ComputerID = os.getComputerID()
    speaker = peripheral.find("speaker")
    --cheeks if phones is a vaild one
    ISVaildPhone = CheekId(ComputerID,ValidPhones)
    if ISVaildPhone == false then
        --shell.run("delete startup")
        os.reboot()
    end
--cheeks if phone is pro or not
    IsProPhones = CheekId(ComputerID,ProPhones)
    --cheeks if phone is a display phone or not
    IsDisplayPhone = CheekId(ComputerID,DisplayPhones)
    LoadSettings()
end

function BackGroundStuff()
while true do
    if GoodTimeToUpdate == true then
    if InstantBootEnabled == 1 then
        shell.run("pastebin get 5nfymkmh TempStartup")
        shell.run("delete startup")
        shell.run("rename TempStartup startup")
    end
    GoodTimeToUpdate = false
    end
    os.sleep(0.5)
end
end

--message goggles forula
-- <message type> <bank money>
function MessageGoggles()
    while true do
        os.sleep(2)
        dataToSend = {}
        dataToSend[1] = "values update"
        if MoneyAMT == nil then MoneyAMT = "error getting value (phone end)" end
        dataToSend[2] = MoneyAMT
        dataToSend = textutils.serialize(dataToSend)
        if NeuralInterfaceID == nil then
        else
            rednet.send(tonumber(NeuralInterfaceID),dataToSend)
        end
    end
end

function UpdateMoney()
while true do
    MoneyAMT = AIKIWIBANKAPI.CheekMoney()
    os.sleep(15)
end
end



LoadSetupOS()
parallel.waitForAll(GuiLoop,BackGroundStuff,MessageGoggles,UpdateMoney)



