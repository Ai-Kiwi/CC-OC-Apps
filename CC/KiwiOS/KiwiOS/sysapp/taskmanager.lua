local MoniterX, MoniterY = term.getSize()
local app_list = {}


term.setBackgroundColor(colors.white)
term.setTextColor(colors.black)

while true do
    Event, app_list = coroutine.yield("app_list")
    MoniterX, MoniterY = term.getSize()

    term.clear()
    for k,v in pairs(app_list) do

        --drawapp name
        term.setCursorPos(1,(k *4) - 2)
        term.setBackgroundColor(colors.lightGray)
        term.setTextColor(colors.black)
        term.write(v.Name)


        --draw path for the app
        term.setCursorPos(1,(k *4) - 1)
        term.setTextColor(colors.black)
        term.write(v.Path)

        --draws kill and restart buttens
        term.setCursorPos(1,(k *4))
        term.setTextColor(colors.black)
        term.setBackgroundColor(colors.red)
        term.write("Kill")

        term.setCursorPos(6,(k *4))
        term.setTextColor(colors.black)
        term.setBackgroundColor(colors.orange)
        --term.write("Restart")
        


    end
    
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.black)

    local event, button, x, y = os.pullEvent()
    --looks if your clicking on a butten
    if event == "mouse_click" then
        AppPicked =  y / 4
        print(AppPicked)
        if app_list[AppPicked] == nil then
        else
            if x >= 1 and x <= 4 then
                --kill app
                coroutine.yield("kill_app",app_list[AppPicked].UUID)
            end
            if x >= 6 and x <= 10 then
                --restart app
                coroutine.yield("restart",app_list[AppPicked].UUID)
            end
        end
    end
end



