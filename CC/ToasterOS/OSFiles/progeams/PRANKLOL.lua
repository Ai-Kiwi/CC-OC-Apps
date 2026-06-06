
speaker = peripheral.find("speaker")

--clear chat function
function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end

ClearChat()
print("how would you like to end your friendship?")
print("1: crepper")
print("2: back")
answer = read()
if answer == 1 then
    speaker.playSound("minecraft:entity.generic.explode")
elseif answer == 2 then

else







