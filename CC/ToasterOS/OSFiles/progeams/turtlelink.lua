rednet.open("back")

function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end


while true do
ClearChat()
term.setTextColor(colors.white)
print("what todo?")
print("1 send message")
print("2 exit")
answer = read()
if answer == "1" then
    ClearChat()
    print("computer to message? (COMPUTER ID) (~ for all)")
    computerToMessage = read()
    if not computerToMessage == "~" then
        computerToMessage = tonumber(computerToMessage)
    end
    print("command to run?")
    text = read()
    if computerToMessage == "~" then
        rednet.broadcast("WirelessToasterTurtleRequest")
        sleep(0.25)
        rednet.broadcast(text)
    else
        computerToMessage = tonumber(computerToMessage)
        rednet.send(computerToMessage,"WirelessToasterTurtleRequest")
        sleep(0.25)
        rednet.send(computerToMessage,text)
    end
elseif answer == "2" then
    os.reboot()
else
    ClearChat()
    term.setTextColor(colors.red)
    print("error unkown comand")
end
end