responce = {}

function SaveUsersMoney()
    settings.load("AiKiwiBankMoneyList")
    settings.set(USERIDSTRING, USERIDMONEY)
    settings.save("AiKiwiBankMoneyList")
end

function LoadUsersMoney()
    settings.load("AiKiwiBankMoneyList")
    USERIDMONEY = settings.get(USERIDSTRING)
    if (USERIDMONEY == nil) then
        USERIDMONEY = 0
    end
    settings.save("AiKiwiBankMoneyList")
end





function MakeTransaction(UserSending,UserGetting,AmmounitToPay)
term.setTextColor(colors.green)
print("removing money from send")
USERIDSTRING = tostring(UserSending)
LoadUsersMoney()
if not (USERIDMONEY < AmmounitToPay) then
    USERIDMONEY = USERIDMONEY - AmmounitToPay
    SaveUsersMoney()
    print("giving money to reciver")
    USERIDSTRING = tostring(UserGetting)
    LoadUsersMoney()
    USERIDMONEY = USERIDMONEY + AmmounitToPay
    SaveUsersMoney()
    print("successful")
    os.sleep(0.1)
    responce = {}
    responce[1] = "Payment responce"
    responce[2] = AmmounitToPay
    responce[3] = UserSending
    responce = textutils.serialize(responce)
    rednet.send(UserGetting,responce)
    
    responce = {}
    responce[1] = "Send Money request responce"
    responce[2] = "payment successful"
    responce = textutils.serialize(responce)
    rednet.send(UserSending,responce)
    
else
    os.sleep(0.1)
    term.setTextColor(colors.red)
    print("User doesn't have money so not doing it")
    responce = {}
    responce[1] = "Send Money request responce"
    responce[2] = "more money needed"
    responce = textutils.serialize(responce)
    rednet.send(UserSending,responce)
end
end

--old system
--function WaitForMoneyMessage()
--    --gets computer getting paid
--    print("waiting for reciver number")
--    NewSenderID, MESSAGETEXT, protocol = rednet.receive(2)
--    if MESSAGETEXT == nil then
--        print("nothing wes sent in")
--    else
--        term.setTextColor(colors.green)
--        if NewSenderID == SenderID then
--            print("Info" .. ", Sender ID : " .. SenderID .. ", MessageText : " .. MESSAGETEXT)
--            SendToUser = tonumber(MESSAGETEXT)
--            --gets user getting paid
--            SenderID, MESSAGETEXT, protocol = rednet.receive(2)
--            if MESSAGETEXT == nil then
--                print("nothing wes sent in")
--            else
--                if NewSenderID == SenderID then
--                    print("Info" .. ", Sender ID : " .. SenderID .. ", MessageText : " .. MESSAGETEXT)
--                    AmmounitToPay = tonumber(MESSAGETEXT)
--                    AmmounitToPay = math.abs(AmmounitToPay)
--                    print("now paying")
--                    MakeTransaction(SenderID,SendToUser,AmmounitToPay)
--
--                else
--                    term.setTextColor(colors.red)
--                    print("incorrect user")
--                end
--            end
--        else
--            term.setTextColor(colors.red)
--            print("incorrect user")
--        end
--
--    end
--end
--
--function OldSystemCheek()
--    SenderID, MESSAGETEXT, protocol = rednet.receive(2)
--    if MESSAGETEXT == nil then 
--        term.setTextColor(colors.red)
--        print("no requetes")
--    else
--        print("Info" .. ", Sender ID : " .. SenderID .. ", MessageText : " .. MESSAGETEXT)
--        if MESSAGETEXT == "Send Money request (AKB)" then 
--            print("got vaild request waiting for values")
--            WaitForMoneyMessage()
--        elseif (MESSAGETEXT == "How Much Money Request") then
--            print("Want to know money ammounit sending to them")
--            USERIDSTRING = tostring(SenderID)
--            LoadUsersMoney()
--            USERIDMONEYString = tostring(USERIDMONEY)
--            rednet.send(SenderID,USERIDMONEYString)
--    
--        else
--            print("nvm it was random noise")
--            term.setTextColor(colors.white)
--        end
--    end
--end

--updates
--updates software
shell.run("delete startup")
shell.run("pastebin get 2sHzGxyL startup")

rednet.open("Right")







while true do 
    SenderID, MESSAGETEXT, protocol = rednet.receive(2)
    if not (MESSAGETEXT ==  nil) then
        Data = {}
        Data = textutils.unserialize(MESSAGETEXT)
        if Data == nil then
            print("Data value is nill")
        else
            if Data[1] == "How Much Money Request" then
                print("Want to know money ammounit sending to them")

                USERIDSTRING = tostring(SenderID)
                LoadUsersMoney()
                USERIDMONEYString = tostring(USERIDMONEY)
                responce = {}
                responce[1] = "How Much Money Request responce"
                responce[2] = USERIDMONEYString
                responceString = textutils.serialize(responce)
                rednet.send(SenderID,responceString)
            elseif Data[1] == "Send Money request (AKB)" then
                print(Data[2])
                print(Data[3])
                MakeTransaction(SenderID,tonumber(Data[2]),tonumber(Data[3]))

            else
                print("werid request")
            end
        end
            
    else
        print("nothing recived")
    end
end



