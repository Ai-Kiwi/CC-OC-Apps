
local function DownloadFromWeb(URL,PATH,NAME)
--get from internet
local request = http.get(URL .. "?cb=" .. math.random(1,9999999))

--clear temp
fs.delete(PATH .. NAME)

--open file
local file = fs.open(PATH .. NAME, "w")
--write out everything
file.write(request.readAll())

--close all the handlers
file.close()
request.close()

end


--docs and info for lib at http://www.computercraft.info/forums2/index.php?/topic/29803-elliptic-curve-cryptography/
DownloadFromWeb("https://pastebin.com/raw/ZGJGBJdg","libs/","ecc.lua")
--i wonder what this does 
DownloadFromWeb("https://raw.githubusercontent.com/Ai-Kiwi/safechat/main/P2P/safechat.lua","libs/","safechat.lua")

--load libs
local ecc = require("libs.ecc")

--create all needed values
local SafeChat = {}
SafeChat.PortUsed = 41260

--bind everything
local modem = peripheral.find("modem")
modem.open(SafeChat.PortUsed)
SafeChat.UsedCode = {}


local function GetNewIpAddress()
  SafeChat.IpAddressSecretCode, SafeChat.IpAddress = ecc.keypair(ecc.random.random())
end
SafeChat.GetNewIpAddress = GetNewIpAddress

--handle messages for sending
local function SendMessage(IpAddress,MessageText)
  --will take clinets a servers codes and make a cross code
  local MessagingEncryptionCode = ecc.exchange(SafeChat.IpAddressSecretCode, IpAddress)
  --use cross code to encrypt data (format includes data and date of sent to fix replay attacks)
  local EncryptedMessage = ecc.encrypt(textutils.serialize({MessageText,os.epoch()}),MessagingEncryptionCode)
  --gets data ready for sending
  local MessageToSend = textutils.serialize({"safechat_P2P","SendMessage",IpAddress,EncryptedMessage,SafeChat.IpAddress})

  --sends out data
  modem.transmit(SafeChat.PortUsed,SafeChat.PortUsed,MessageToSend)


end
SafeChat.SendMessage = SendMessage


local function LookForReceivedMessage(TimeOutTime)
  --stuff for knowing when to pull out of loop
  local TimerCode = 0
  TimerCode = os.startTimer(1)
  local StartTime = os.clock()
  --runs a loop waiting for output
  while true do
    --gets user input
    local EventTable = {}
    --proper way of doing this keep crashing so ive not done it
    EventTable = {os.pullEvent()}

    --looks if its a message
    if EventTable[1] == "modem_message" then
      --creates a textutils things
      local TableOfMessage = textutils.unserialize(EventTable[5])
      --looks if its a message for me and useing protcal
      if TableOfMessage[1] == "safechat_P2P" and TableOfMessage[2] == "SendMessage" and TableOfMessage[3] == SafeChat.IpAddress then
        -- reads data
        local MessagingEncryptionCode = ecc.exchange(SafeChat.IpAddressSecretCode, TableOfMessage[5])
        local TableOfData = textutils.unserialize(ecc.decrypt(TableOfMessage[4],MessagingEncryptionCode))

        --looks if the code has been used before (stop replay attack)
        if SafeChat.UsedCodes[ TableOfData[2] ] == nil then
          --save code as used
          SafeChat.UsedCodes[ TableOfData[2] ] = true
          --message is way to old so ignore
          if (TableOfData[2] - 10) > os.epoch() then
            return TableOfData[1],  TableOfMessage[5]
          end
        end
      end
    end

    --do some sketchy stuff for looking when to close
    if EventTable[1] == "timer" then
      TimerCode = os.startTimer(1)
    end

    if TimeOutTime then
      if os.clock < (StartTime - TimeOutTime) then
        break
      end
    end
  end

end
SafeChat.LookForReceivedMessage = LookForReceivedMessage

local function ConvertIpAddressToString(IpAddress)
  local String = ""
  local ConvertTable = {}
  ConvertTable[0] = "0"
  ConvertTable[1] = "a"
  ConvertTable[2] = "b"
  ConvertTable[3] = "c"
  ConvertTable[4] = "d"
  ConvertTable[5] = "e"
  ConvertTable[6] = "f"
  ConvertTable[7] = "g"
  ConvertTable[8] = "h"
  ConvertTable[9] = "i"
  ConvertTable[10] = "j" 
  ConvertTable[11] = "k"
  ConvertTable[12] = "l"
  ConvertTable[13] = "m"
  ConvertTable[14] = "n"
  ConvertTable[15] = "o"
  ConvertTable[16] = "p"
  ConvertTable[17] = "q"
  ConvertTable[18] = "r"
  ConvertTable[19] = "s"
  ConvertTable[20] = "t"
  ConvertTable[21] = "u"
  ConvertTable[22] = "v"
  ConvertTable[23] = "w"
  ConvertTable[24] = "x"
  ConvertTable[25] = "y"
  ConvertTable[26] = "z"
  

  for i,v in ipairs(IpAddress) do
    number = v
    NumberLoop = 0
    while number > 26 do
      number = number - 26
      NumberLoop = NumberLoop + 1
    end
    String = String .. ConvertTable[NumberLoop]
    String = String .. ConvertTable[number]
  
  end

  return String
end
SafeChat.ConvertIpAddressToString = ConvertIpAddressToString

local function ConvertStringToIpAddress(IpAddress)
  local ConvertTable = {}
  ConvertTable["0"] = 0
  ConvertTable["a"] = 1
  ConvertTable["b"] = 2
  ConvertTable["c"] = 3
  ConvertTable["d"] = 4
  ConvertTable["e"] = 5
  ConvertTable["f"] = 6
  ConvertTable["g"] = 7
  ConvertTable["h"] = 8
  ConvertTable["i"] = 9
  ConvertTable["j"] = 10
  ConvertTable["k"] = 11
  ConvertTable["l"] = 12
  ConvertTable["m"] = 13
  ConvertTable["n"] = 14
  ConvertTable["o"] = 15
  ConvertTable["p"] = 16
  ConvertTable["q"] = 17
  ConvertTable["r"] = 18
  ConvertTable["s"] = 19
  ConvertTable["t"] = 20
  ConvertTable["u"] = 21
  ConvertTable["v"] = 22
  ConvertTable["w"] = 23
  ConvertTable["x"] = 24
  ConvertTable["y"] = 25
  ConvertTable["z"] = 26
  local Result = {} 
  for i=1, (math.floor(#IpAddress / 2)) do
    Result[i] = (ConvertTable[string.sub(IpAddress ,(i * 2) - 1,(i * 2) - 1 )] * 26) + ConvertTable[string.sub(IpAddress ,(i * 2) ,(i * 2))]
    
    
    
    
    
  
  end
      
  return Result
end
SafeChat.ConvertStringToIpAddress = ConvertStringToIpAddress

return SafeChat
