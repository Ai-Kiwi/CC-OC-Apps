--get the background color
 -- local DesktopSettingsFile = fs.open("/UserData/desktop/.settings.conf", "r")
 -- local DesktopSettings = DesktopSettingsFile.readAll()
 -- DesktopSettingsFile.close()
 -- DesktopSettings = textutils.unserialize(DesktopSettings)



local FristColor = colors.blue
local SecondColor = colors.lightBlue

local OldX, OldY = 0,0

while true do
    term.redirect(term.native)

    local MoniterX, MoniterY = term.getSize()
    if MoniterX == OldX and MoniterY == OldY then
    else
        for y=1, MoniterY do
            for x=1, MoniterX do
                if math.floor((y + x)/2) == (y + x) / 2 and false then
                    term.setBackgroundColor(FristColor)
                    term.setTextColor(SecondColor)
                else
                    term.setBackgroundColor(SecondColor)
                    term.setTextColor(FristColor)
                end
                term.setCursorPos(x,y)
                term.write(" ")
            end
        end
        OldX, OldY = MoniterX, MoniterY 
    end


    coroutine.yield()
end