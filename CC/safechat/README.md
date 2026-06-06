# safechat
safechat is a computer craft messaging program for securely messaging other computers.


# HowToUse  
```
--create a ip address
safechat.GetNewIpAddress()

--look for new messages
Message, IpAddressFrom = safechat.LookForReceivedMessage(TimeOutTime)

--send a message
safechat.SendMessage(IpAddress,MessageText)

--print ip address
print(safechat.IpAddress)

--convert Ip Address to string
safechat.ConvertIpAddressToString

--convert string to Ip Address
safechat.ConvertStringToIpAddress
```
```
--ToBeAddedLater  
safechat.LoadIpFromFile()
safechat.SaveIpToFile()
safechat.CheckEventInput()
```
# install
```
wget run https://raw.githubusercontent.com/Ai-Kiwi/safechat/main/P2P/safechat.lua
```

# plans 

allow support for computers without peripherals to be able to talk still.  







