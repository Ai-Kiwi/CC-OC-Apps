local args = {...}
local TimeStartedSinceDrawing = os.epoch("utc")
local MoniterX, MoniterY = term.getSize()

if args[1] == nil then return end
if args[2] == nil then return end
if args[3] == nil then return end

local AppsRunnning = args[1]
local WindowManagerSettings = args[2]
local SelectedApp = args[3]
local SelectedAppObject = nil

local orginal_Background = colors.lightBlue
local orginal_TextColor = term.getTextColor()

for k,v in pairs(AppsRunnning) do
    if v.UUID == SelectedApp then
        SelectedAppObject = v
    end



    


    if v.Window.WindowMode == "1" then 

        term.setBackgroundColor(WindowManagerSettings.WindowBorderColor)
        term.setTextColor(orginal_Background)

        --top left corner of the window
        term.setCursorPos(v.Window.x - 1,v.Window.y - 1)
        term.write("\159")

        --left
        for i=1, v.Window.height do
            term.setCursorPos(v.Window.x - 1,v.Window.y + i - 1)
            term.write("\149")
        end

        --top
        term.setCursorPos(v.Window.x,v.Window.y - 1)
        for i=1, v.Window.width do
            term.write("\143")
        end

        term.setBackgroundColor(orginal_Background)
        term.setTextColor(WindowManagerSettings.WindowBorderColor)


        --top right
        term.setCursorPos(v.Window.x + v.Window.width ,v.Window.y - 1)
        term.write("\144")


        --bottom lef
        term.setCursorPos(v.Window.x - 1,v.Window.y + 0 + v.Window.height)
        term.write("\130")

        --bottom right
        term.setCursorPos(v.Window.x + v.Window.width,v.Window.y + v.Window.height)
        term.write("\129")

        --right
        for i=1, v.Window.height do
            term.setCursorPos(v.Window.x + v.Window.width,v.Window.y - 1 + i)
            term.write("\149")
        end

        --bottem

        for i=1, v.Window.width do
            term.setCursorPos(v.Window.x + i - 1,v.Window.height + v.Window.y)
            term.write("\131")
        end

        term.setBackgroundColor(WindowManagerSettings.WindowBorderColor)
        term.setTextColor(orginal_Background)

        if v.UUID == SelectedApp then
            term.setTextColor(colors.black)
        else
            term.setTextColor(colors.gray)
        end
        --draws program name text
        term.setCursorPos(v.Window.x,v.Window.y - 1)
        term.write(string.sub(v.Name .. " - " .. v.UUID,1,v.Window.width - 4 ))

        --draws delete and minaize buttons
        --close
        term.setCursorPos(v.Window.x + v.Window.width - 1,v.Window.y - 1)
        term.setBackgroundColor(colors.red)
        term.write("x")
        --sleep
        term.setCursorPos(v.Window.x + v.Window.width - 2,v.Window.y - 1)
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.gray)
        term.write("-")
        --nothing yet






        --redraw the window
        v.Window.WindowObject.redraw()

    elseif v.Window.WindowMode == "2" then
        v.Window.WindowObject.redraw()




    elseif v.Window.WindowMode == "0" then
        --nothing lmao

    elseif v.Window.WindowMode == "3" then
        v.Window.WindowObject.redraw()


    else
        v.Window.WindowMode = "1"
    
    end

    term.setBackgroundColor(orginal_Background)
    term.setTextColor(orginal_TextColor)
    
end

-- --draws debug info
-- term.setBackgroundColor(colors.black)
-- term.setTextColor(colors.white)
-- 
-- term.setCursorPos(1,1)
-- for k,v in pairs(AppsRunnning) do
--     print(v.UUID .. " " .. v.Name .. " " .. v.CoroutineTime)
-- end
-- print("Time: " .. os.epoch("utc") - TimeStartedSinceDrawing)
-- --print size of the window
-- local MoniterX, MoniterY = term.getSize()
-- print("Window Size: " .. MoniterX .. "x" .. MoniterY)

--draws text if key is not lisanced
--lmoa not coded so it just always says it

--term.setBackgroundColor(colors.white)
--term.setTextColor(colors.black)
--term.setCursorPos(MoniterX - 13,MoniterY - 2)
--term.write("unlisanced")


term.setBackgroundColor(orginal_Background)
term.setTextColor(orginal_TextColor)

if SelectedAppObject == nil then
else
    --term.redirect(SelectedAppObject.Window.WindowObject)
    SelectedAppObject.Window.WindowObject.restoreCursor()

end



