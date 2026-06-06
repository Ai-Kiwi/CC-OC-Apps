function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end

while true do
    x,y,z = gps.locate()
    ClearChat()
    print(x)
    print(y)
    print(z)
end