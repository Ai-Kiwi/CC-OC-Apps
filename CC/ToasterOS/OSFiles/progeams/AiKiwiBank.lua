


function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end
-- pastebin.com/HjCMwyBP

ClearChat()

--get api useing
shell.run("delete AIKIWIBANKAPI")
shell.run("pastebin get WxsMPXqi AIKIWIBANKAPI")
os.loadAPI("AIKIWIBANKAPI")

rednet.open("back")
ServerID = 28

while true do

--gets how much money you have
MoneyAmmounit = AIKIWIBANKAPI.CheekMoney()

--prints how much money you have
ClearChat()
term.setTextColor(colors.green)
term.setCursorPos(1,19)
print(MoneyAmmounit)

--main menu message
term.setCursorPos(1,1)
term.setTextColor(colors.white)
print("Ai Kiwi Bank")
print("1 : send money")
print("2 : buy from shops")
print("3 : back")
answer = read()

--when something is picked
if answer == "1" then
    --send money to someone script
    ClearChat()
    print("Ai Kiwi Bank")
    print("How much to pay?")
    ammounit = read()
    ClearChat()
    print("Ai Kiwi Bank")
    print("ID to send to")
    SendTOID = read()
    result = AIKIWIBANKAPI.PayMoney(SendTOID,ammounit)
    print(result)
    answer = read()

elseif answer == "2" then

elseif answer == "3" then
    os.reboot()
end

end