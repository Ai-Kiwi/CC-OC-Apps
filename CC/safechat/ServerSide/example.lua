-- hosting server
safechat = require("safechat")

safechat.StartServer(<pravite key>,<public key>)

--creating keys
crypto = peripheral.wrap("bottom")

local NewRSAKeys = crypto.generateRSAKeys(1024)

local ServerOpened = fs.open("output","w")
ServerOpened.write("private : " .. crypto.encodeBase64(NewRSAKeys["private"]) .. "\n")
ServerOpened.write("public : " .. crypto.encodeBase64(NewRSAKeys["public"]))
ServerOpened.close()

--clinet pinging self


safechat.GetIpAddressFromServer(<public RSA>)

print("i got ip " .. safechat.IPADDRESS)


safechat.MessageServer("ping",safechat.IPADDRESS)

local MessageText, IpAddressFrom = safechat.WaitForMessage()
print("message done got")
print(MessageText)
print(IpAddressFrom)

--use binded ip address
-- `safechat help` to find out how to add static ip
-- make sure the code you use is a long random string. HIGHLY SUGGEST YOU USE A RANDOM STRING GENRATOR AND WRITE DOWN THE CODE.
safechat.GetIpAddressFromServer(<public RSA>,<code>)
