ServerID = 28
-- pastebin URL pastebin.com/WxsMPXqi
local SendMessage = {}
local returnMessage = {}
local Moneyamt = 0

--forula for sending stuff
--sending request {Request type, values}
--returning request {Request type, values}

function CheekMoney()
    SendMessage = {}
    SendMessage[1] = "How Much Money Request"
    SendMessage = textutils.serialize(SendMessage)
    rednet.send(ServerID,SendMessage)

    SenderID, MESSAGETEXT, protocol = rednet.receive(1)
    if MESSAGETEXT then
        MESSAGETEXT = textutils.unserialize(MESSAGETEXT)
        if not (MESSAGETEXT == nil) then
            if MESSAGETEXT[1] == "How Much Money Request responce" then
                Moneyamt = MESSAGETEXT[2]
                if SenderID == ServerID then
                    Moneyamt = tonumber(Moneyamt)
                    return Moneyamt
                end
            end
        end
    end
end



function CheekForPayment(TimeoutTime)
    if TimeoutTime == nil then
        TimeoutTime = 2
    end
    SenderID, MESSAGETEXT, protocol = rednet.receive(TimeoutTime)
    if SenderID == ServerID then
        MESSAGETEXT = textutils.unserialize(MESSAGETEXT)
        if MESSAGETEXT[1] == "Payment responce" then 
            amtbeenpaid = tonumber(MESSAGETEXT[2])
            UserThatPaid = tonumber(MESSAGETEXT[3])
            return amtbeenpaid, UserThatPaid
        end
    end
end

function PayMoney(SendTOID,ammounit)
    SendMessage = {}
    SendMessage[1] = "Send Money request (AKB)"
    SendMessage[2] = SendTOID
    SendMessage[3] = ammounit
    SendMessage = textutils.serialize(SendMessage)
    rednet.send(ServerID,SendMessage)

    SenderID, MESSAGETEXT, protocol = rednet.receive(1)
    if not (MESSAGETEXT ==  nil) then
        MESSAGETEXT = textutils.unserialize(MESSAGETEXT)
        if MESSAGETEXT[1] == "Send Money request responce" then
            if SenderID == ServerID then
                return MESSAGETEXT[2]
            end
        end
    end
end

--function PayMoney(SendTOID,ammounit)
--    if pocket then
--        textcolor = term.getTextColor()
--        term.setTextColor(colors.red)
--        term.clear()
--        term.setCursorPos(1,1)
--        print("an app is trying todo a transacstion")
--        term.setTextColor(colors.green)
--        print(ammounit .. " bread crumbs to ID " .. SendTOID)
--        print("Y : allow, N : Deny")
--        answer = read()
--        if answer == "Y" then
--            term.setTextColor(textcolor)
--            paymentconfermed(SendTOID,ammounit)
--        else
--            term.setTextColor(colors.red)
--            print("Ok blocked it for you. your welcome")
--            term.setTextColor(textcolor)
--            answer = read()
--        end
--    else
--        paymentconfermed(SendTOID,ammounit)
--    end
--end