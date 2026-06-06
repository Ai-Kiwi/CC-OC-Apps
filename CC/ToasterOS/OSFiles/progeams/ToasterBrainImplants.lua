local modules = peripheral.find("neuralInterface")
local canvas = modules.canvas()
if not modules.hasModule("plethora:glasses") then error("overly glasses are needed",0) end
canvas.clear()
speaker = peripheral.find("speaker")
rednet.open("top")




function SaveSettings()
    settings.load("toasterOSBrainLinkSettings")
    settings.set("PhoneID", PhoneID)
    settings.set("GUISCALE", GUISCALE)
    settings.save("toasterOSBrainLinkSettings")
end

function LoadSettings()
settings.load("toasterOSBrainLinkSettings")
PhoneID = settings.get("PhoneID")
GUISCALE = settings.get("GUISCALE")
settings.save("toasterOSBrainLinkSettings")
if not PhoneID then PhoneID = 0 end
if not GUISCALE then GUISCALE = 0.75 end
PhoneID = tonumber(PhoneID)
end


--clear chat function
function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.white)
end

function DebugData(DataToDebug)
    
end


function drawScreen()
    while true do
        canvas.clear()
        GetTime()
        if not (PlayerXPOS == nil) then
            PlayerLOCText = ("X : " .. PlayerXPOS .. " Y : " .. PlayerYPOS .. " Z : " .. PlayerZPOS)
            ChangeBy = ((GUISCALE - 1) * 5)
            canvas.addText({1,280 - ChangeBy},PlayerLOCText,0xFFFFFFFF,GUISCALE * 1)
        end
        if PLAYERBANKBLANCESTRING == nil then
        else
            ChangeBy = 280 - (7.5 * GUISCALE) + ((GUISCALE - 1) * -5)
            canvas.addText({1,ChangeBy},PLAYERBANKBLANCESTRING .. " BreadCrumbs",0xFFFFFFFF,GUISCALE * 0.75)
        end
        ChangeBy = 280 - (17.5 * GUISCALE) + ((GUISCALE - 1) * -5)
        canvas.addText({1,ChangeBy},time,0xFFFFFFFF,GUISCALE * 1.25)
        if DebugMessage == nil then DebugMessage = "nil" end
        canvas.addText({1,1},DebugMessage,0xFFFFFFFF,GUISCALE * 0.5)
        os.sleep(0.5)
    end
end

function PhoneLinkTrafficHandler()
while true do
    SenderID, MESSAGETEXT, protocol = rednet.receive(2)
    if MESSAGETEXT == nil then 
        DebugData("got nothing")
    else
        DebugData("got data not nill")
        PhoneID = tonumber(PhoneID)
        if SenderID == PhoneID then
            DebugData("was right user")
            DebugMessage = (SenderID .. " : " .. MESSAGETEXT)
            DebugData(SenderID .. " : " .. MESSAGETEXT)
            request = textutils.unserialize(MESSAGETEXT)
            if request[1] == "play sound request" then
                speaker.playSound(request[2])
                DebugData("playing sound")
            elseif request[1] == "values update" then
                DebugData("setting values")
                PLAYERBANKBLANCE = request[2]
                PLAYERBANKBLANCESTRING = tostring(PLAYERBANKBLANCE)
            end

        end
    end
end
end

function GetTime()
    time = os.time()
    pm = false
    if time > 12 then 
        pm = true
        time = time - 12
    end
    time = time * 100
    time = math.floor(time)
    time = time / 100
    
    TimeFloored = math.floor(time)
    TimeDecimal = time - TimeFloored
    TimeDecimal = (TimeDecimal / 100) * 60
    TimeDecimal = TimeDecimal * 100
    TimeDecimal = math.floor(TimeDecimal)

    time = (TimeFloored .. ":" .. TimeDecimal)
    time = tostring(time)
    if pm then
        time = (time .. "PM")
    else
        time = (time .. "AM")
    end
end


function GUI()
    while true do
        ClearChat()
        print("Main Menu")
        print("1 : SetPhoneID")
        print("2 : Gui Scale?")
        print("3 : reboot")
        answer = read()
        if answer == "1" then
            print("New Phone ID?")
            PhoneID = read()
            SaveSettings()
            LoadSettings()
        elseif answer == "2" then
            print("gui scale? (0.75 is defalt)")
            GUISCALE = read()
            SaveSettings()
            LoadSettings()
        elseif answer == "3" then
            os.reboot()
        end
    end

end

function GetValuesFromCHIP()
while true do
    PlayerXPOS, PlayerYPOS, PlayerZPOS = gps.locate()
    os.sleep(1)
end
end

LoadSettings()

function autoreboot()
    os.sleep(120)
    os.reboot()
end


shell.run("label set IToasterHead")
parallel.waitForAll(PhoneLinkTrafficHandler,drawScreen,GUI,GetValuesFromCHIP,autoreboot)