local args = {...}

shell.run("delete tempsafechat.lua")
shell.run("wget https://raw.githubusercontent.com/Ai-Kiwi/safechat/main/ServerSide/safenet.lua tempsafechat.lua")
shell.run("delete safechat.lua")
shell.run("rename tempsafechat.lua safechat.lua")

safechat = {}
safechat.crypto = peripheral.find("cryptographic_accelerator")
safechat.modem = peripheral.find("modem")

safechat.MessageingChannel = 36963
safechat.modem.open(safechat.MessageingChannel)

--crypto.encodeBase64(data: string)

--crypto.decodeBase64(base64: string)

if args[1] == "help" then
    print("add server ip by running `safechat add_static_ip <code> <URL>` (make sure code is random)")


end

if args[1] == "add_static_ip" then

    if fs.isDir("safechat/") == false then
        fs.makeDir("safechat/")
    end

    local contents = nil
    local file = fs.open("safechat/StaticIPS.txt", "r")
    if file == nil then
        print("making file")
        local file = fs.open("safechat/StaticIPS.txt", "w")
        local BaseValue = {}
        BaseValue["SHA512-KEY"] = "URL"
        file.write(textutils.serialise(BaseValue))
        file.close()
        local file = fs.open("safechat/StaticIPS.txt", "r")
        contents = file.readAll()
        file.close()
    else
        print("reading file")
        contents = file.readAll()
        file.close()
    end


    local StaticIpAddresses = textutils.unserialise(contents)
    StaticIpAddresses[safechat.crypto.encodeBase64(safechat.crypto.hashSHA512(args[2]))] = args[3]

    local fileOpen = fs.open("/safechat/StaticIPS.txt", "w")
    local contents = fileOpen.write(textutils.serialise(StaticIpAddresses))
    fileOpen.close()

end






--start server
local function StartServer(RawRSAPrivate,RawRSAPublic)
    local RSAPrivate = safechat.crypto.decodeBase64(RawRSAPrivate)
    local RSAPublic = safechat.crypto.decodeBase64(RawRSAPublic)

    local MoniterX, MoniterY = term.getSize()
    
    -- StaticIpAddresses[<code>] = <IP ADDRESS TO SET TO>
    local StaticIpAddresses = {}
    local file = fs.open("safechat/StaticIPS.txt", "r")
    if file == nil then
    else
        contents = file.readAll()
        StaticIpAddresses = textutils.unserialise(contents)
        file.close()
        
    end
    


    IpAddressList = {}
    UsedCommands = {}
    -- frist value AES KEY
    -- secand value IV KEY
    local IpAddressSavedOnServer = 0
    local MessagesSentOnServer = 0
    local DeninedRequests = 0

    safechat.SendablePublicRSA = safechat.crypto.encodeBase64(RSAPublic)
    local DiskplayCommands = {}

    local function DebugPrint(Message)
        term.setTextColour(colors.white)
        term.setCursorPos(1,MoniterY)
        print(os.clock() .. " : " .. Message)




        term.setCursorPos(1,1)
        term.clearLine()
        print("Loaded Ai_Kiwi Server verson 2.1")
        term.clearLine()
        print("Ip addresses connected to network : " .. IpAddressSavedOnServer)
        term.clearLine()
        print("Messages sent : " .. MessagesSentOnServer)
        term.setTextColour(colors.red)
        term.clearLine()
        print("Blocked Requests: " .. DeninedRequests)

        term.clearLine()


    end
    DebugPrint("started server")
    
    while true do

        local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        if event == "modem_message" then
            DebugPrint("see meassage")
            local MessageOutput = textutils.unserialise(message)
            if MessageOutput[2] == safechat.SendablePublicRSA then
                DebugPrint("is me talking to")
                if MessageOutput[1] == "AKSS_GET_IP" then
                    DebugPrint("user is asking for ip")

                    local HashedIpAddressCode = ""
                    local UnEncryptedData = textutils.unserialise(safechat.crypto.decryptRSA(MessageOutput[3],RSAPrivate))
                    local AESKEY = safechat.crypto.decodeBase64(UnEncryptedData[1])
                    local AESIV = safechat.crypto.decodeBase64(UnEncryptedData[2])
                    if UnEncryptedData[3] == nil then
                        HashedIpAddressCode = ""
                    else
                        HashedIpAddressCode = safechat.crypto.encodeBase64(safechat.crypto.hashSHA512(UnEncryptedData[3]))
                    end

                    
                    if StaticIpAddresses["" .. HashedIpAddressCode] == nil then
                        local NewIpAddress = ""
                        for i=1, 4 do
                            NewIpAddress = NewIpAddress .. math.random(1,255)
                            if i==4 then
                            else
                            NewIpAddress = NewIpAddress .. "."
                            end
                        end

                        if IpAddressList[NewIpAddress] == nil then
                            IpAddressList[NewIpAddress] = {safechat.crypto.decodeBase64(UnEncryptedData[1]),safechat.crypto.decodeBase64(UnEncryptedData[2])}
                            DebugPrint("gave them the ip " .. NewIpAddress)
                            IpAddressSavedOnServer = IpAddressSavedOnServer + 1
                            safechat.modem.transmit(safechat.MessageingChannel,safechat.MessageingChannel,textutils.serialise({"AKSS_RESPOND_GET_IP",safechat.SendablePublicRSA,safechat.crypto.encryptAES(NewIpAddress,AESKEY,AESIV)}))
                        else
                            DeninedRequests = DeninedRequests + 1
                            DebugPrint("already have that ip lol")
                        end
                    else
                        local NewIpAddress = StaticIpAddresses[HashedIpAddressCode]

                        IpAddressList[NewIpAddress] = {safechat.crypto.decodeBase64(UnEncryptedData[1]),safechat.crypto.decodeBase64(UnEncryptedData[2])}
                        DebugPrint("gave them the ip " .. NewIpAddress)
                        IpAddressSavedOnServer = IpAddressSavedOnServer + 1
                        safechat.modem.transmit(safechat.MessageingChannel,safechat.MessageingChannel,textutils.serialise({"AKSS_RESPOND_GET_IP",safechat.SendablePublicRSA,safechat.crypto.encryptAES(NewIpAddress,AESKEY,AESIV)}))



                    end
                elseif  MessageOutput[1] == "AKSS_MESSAGE_SEND" then
                    DebugPrint("user trying to send message")

                    --MessageOutput[4]
                    if IpAddressList[MessageOutput[3]] == nil then
                    else
                        local UnEncryptedData = textutils.unserialise(safechat.crypto.decryptAES( MessageOutput[4] , IpAddressList[MessageOutput[3]][1] , IpAddressList[MessageOutput[3]][2] ))
                        local GettingIpAddress = UnEncryptedData[1]
                        if IpAddressList[GettingIpAddress] == nil then
                        else

                            if UsedCommands[safechat.crypto.hashSHA512(message)] == true then
                                DeninedRequests = DeninedRequests + 1
                                DebugPrint("user is doing reply attack")
                            else
                                UsedCommands[safechat.crypto.hashSHA512(message)] = true
                                DebugPrint("sending user data")
                                MessagesSentOnServer = MessagesSentOnServer + 1
                                safechat.modem.transmit(safechat.MessageingChannel,safechat.MessageingChannel,textutils.serialise({"AKSS_MESSAGE_RESPOND",safechat.SendablePublicRSA,GettingIpAddress,safechat.crypto.encryptAES(textutils.serialise({MessageOutput[3],UnEncryptedData[2]}),IpAddressList[GettingIpAddress][1],IpAddressList[GettingIpAddress][2])}))
                            end

                        end

                    -- "AKSS_MESSAGE_SEND",<RSA CODE>,<SENDING IP ADDRESS>,[<GETTING IP ADDRESS>,<Message>,<random data (stop replay attacks) >]
                    -- "AKSS_MESSAGE_RESPOND",<RSA CODE>,<GETTING IP ADDRESS>,[<SENDING IP ADDRESS>,<Message>]
                    end
                end
            end
        end



    end
end
safechat.StartServer = StartServer

--start clinet

local function GetIpAddressFromServer(RawPublicRSA,CodeForStaticIP)
    local PublicRSA = safechat.crypto.decodeBase64(RawPublicRSA)

    safechat.SendablePublicRSA = safechat.crypto.encodeBase64(PublicRSA)
    safechat.IPADDRESS = nil
    safechat.AESKEY = safechat.crypto.randomBytes(16)
    safechat.AESIVCODE = safechat.crypto.randomBytes(16)
    safechat.RSAServer = PublicRSA

    safechat.modem.transmit(safechat.MessageingChannel,safechat.MessageingChannel,textutils.serialise({"AKSS_GET_IP",safechat.SendablePublicRSA,safechat.crypto.encryptRSA(textutils.serialise({safechat.crypto.encodeBase64(safechat.AESKEY),safechat.crypto.encodeBase64(safechat.AESIVCODE),CodeForStaticIP}),PublicRSA)}))

    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    local message = textutils.unserialise(message)
    if message[1] == "AKSS_RESPOND_GET_IP" and message[2] == safechat.SendablePublicRSA then
        safechat.IPADDRESS =  safechat.crypto.decryptAES(message[3],safechat.AESKEY,safechat.AESIVCODE)
        return safechat.IPADDRESS
    end

    return

end
safechat.GetIpAddressFromServer = GetIpAddressFromServer

local function MessageServer(Message,IpAddressToSendTo)
    if safechat.IPADDRESS == nil then
    else

        safechat.modem.transmit(safechat.MessageingChannel,safechat.MessageingChannel,textutils.serialise({"AKSS_MESSAGE_SEND",safechat.SendablePublicRSA,safechat.IPADDRESS,safechat.crypto.encryptAES(textutils.serialise({IpAddressToSendTo,Message,os.time() * os.clock()}),safechat.AESKEY,safechat.AESIVCODE)}))

    end
end
safechat.MessageServer = MessageServer

local function WaitForMessage()
    while true do
        if safechat.IPADDRESS == nil then
        else
            local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
            local OutputEvent = textutils.unserialise(message)
            if OutputEvent == nil then
            else
                if OutputEvent[1] == "AKSS_MESSAGE_RESPOND" and OutputEvent[2] == safechat.SendablePublicRSA and OutputEvent[3] == safechat.IPADDRESS then
                    local NewOutputEvent = textutils.unserialise(safechat.crypto.decryptAES(OutputEvent[4],safechat.AESKEY,safechat.AESIVCODE))

                    return NewOutputEvent[2], NewOutputEvent[1]


                end
            end



        end
    end
end
safechat.WaitForMessage = WaitForMessage





-- "AKSS_GET_IP",<RSA CODE>,[aes responce,IV Responce]
-- "AKSS_RESPOND_GET_IP",<RSA CODE>,[Ip Address]


-- "AKSS_MESSAGE_SEND",<RSA CODE>,<SENDING IP ADDRESS>,[<GETTING IP ADDRESS>,<Message>,<random data (stop replay attacks) >]
-- "AKSS_MESSAGE_RESPOND",<RSA CODE>,<GETTING IP ADDRESS>,[<SENDING IP ADDRESS>,<Message>]







return safechat
