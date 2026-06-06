--updates software
shell.run("delete startup")
shell.run("pastebin get P4tC2Vda startup")

--vaild phones
OwnersOfLinkSoftware = {5,2}

function CheekId (ComputerIDCheek,PhoneList)
    for _, v in pairs (PhoneList) do
      if v == ComputerIDCheek then
        return true
      end
    end
    return false
end

function cheekturtleID()
turtleId = os.getComputerID()
vaildDevice = CheekId (turtleId,OwnersOfLinkSoftware)
vaildDevice = true
if vaildDevice then
    term.setTextColor(colors.green)
    print("Vaild Lisance Welcome")
else
    term.setTextColor(colors.red)
    print("sorry you need to get a lisance")
    print("Your Computer ID is " .. turtleId)
    answer = read()
    os.reboot()
end
end

term.setTextColor(colors.white)

function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end

function SaveSettings()
    settings.load("toasterOSLINKSettings")
    settings.set("ToasterOSWhiteListDevice", whitelistDevice)
    settings.save("toasterOSLINKSettings")
end
function LoadSettings()
    settings.load("toasterOSLINKSettings")
    whitelistDevice = settings.get("ToasterOSWhiteListDevice")
    settings.save("toasterOSLINKSettings")
end



ClearChat()
term.setTextColor(colors.yellow)
print("Running toaster os link verson 1.51")
cheekturtleID()
term.setTextColor(colors.white)
LoadSettings()
if whitelistDevice == nil then
    print("this appears to be your frist time please set a whitelist device")
    whitelistDevice = read()
    SaveSettings()

else
    print("found whitelistDevice. value is " .. whitelistDevice)
end
whitelistDevice = tonumber(whitelistDevice)





function runcommand()
SenderID, MESSAGETEXT, protocol = rednet.receive(2)
if MESSAGETEXT == nil then 
    term.setTextColor(colors.red)
    print("nothing recived Going back to waiting")
else
    term.setTextColor(colors.white)
    print("got something")
    print("Info" .. ", Sender ID : " .. SenderID .. ", MessageText : " .. MESSAGETEXT)
    if SenderID == whitelistDevice then
        term.setTextColor(colors.green)
        print("Gotten user command now running")
        term.setTextColor(colors.white)
        shell.run(MESSAGETEXT)
    else
        if SenderID == 9 then
            term.setTextColor(colors.green)
            print("User is Admin so now running command")
            term.setTextColor(colors.white)
            shell.run(MESSAGETEXT)
        else
            term.setTextColor(colors.red)
            print("user not in whitelist not running command")
        end

    end

end
end








rednet.open("left")

while true do
term.setTextColor(colors.white)
SenderID, MESSAGETEXT, protocol = rednet.receive(5)
if MESSAGETEXT == nil then 
    term.setTextColor(colors.red)
    print("nothing recived")
else
    if MESSAGETEXT == "WirelessToasterTurtleRequest" then 
        term.setTextColor(colors.green)
        print("recived")
        print("Info" .. ", Sender ID : " .. SenderID .. ", MessageText : " .. MESSAGETEXT)

        if SenderID == whitelistDevice then
            term.setTextColor(colors.green)
            print("user waiting for command")
            term.setTextColor(colors.white)
            runcommand()
        else
            if SenderID == 9 then
                term.setTextColor(colors.green)
                print("user is Admin waiting for command")
                term.setTextColor(colors.white)
                runcommand()
            else
                term.setTextColor(colors.red)
                print("user not in whitelist not running command")
            end

        end
    else
        term.setTextColor(colors.red)
        print("BackGround Noise, ignoreing")
    end
end
end