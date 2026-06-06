local TextSearching = ""
local SearchOffset = 0
local SelectedApp = nil

local function UpdateScreen()
    --update taskbar to correct cords
    local Event, ScreenX, ScreenY = coroutine.yield("get_screen_size")

    local AppsOnSystem = fs.list("UserData/Apps/")

    local WindowSizeY = math.floor(ScreenY / 2)
    local WindowSizeX = math.floor(ScreenX / 3)

    coroutine.yield("set_window_size", WindowSizeX, WindowSizeY)
    coroutine.yield("set_window_position", 1, ScreenY - WindowSizeY)

    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.black)
    term.clear()



    if TextSearching == "" then

        local DrawUpto = 0
        for k, v in pairs(AppsOnSystem) do
            if string.find(v, TextSearching) then
                DrawUpto = DrawUpto + 1
                if DrawUpto == SearchOffset + 1 then
                    term.setBackgroundColor(colors.lightGray)
                    term.setCursorPos(2, DrawUpto)
                    term.write(v)
                    term.setBackgroundColor(colors.white)
                    SelectedApp = v
                else
                    term.setCursorPos(1, DrawUpto)
                    term.write(v)
                end
            end
        end
        if SearchOffset > DrawUpto - 1 then
            SearchOffset = DrawUpto - 1
        end
    else
        term.setCursorPos(1, 1)
        term.setBackgroundColor(colors.lightGray)
        term.clearLine()
        term.write(TextSearching)
        term.setBackgroundColor(colors.white)

        local DrawUpto = 0
        for k, v in pairs(AppsOnSystem) do
            if string.find(v, TextSearching) then
                DrawUpto = DrawUpto + 1
                if DrawUpto == SearchOffset + 1 then
                    term.setBackgroundColor(colors.lightGray)
                    term.setCursorPos(2, DrawUpto + 2)
                    term.write(v)
                    term.setBackgroundColor(colors.white)
                    SelectedApp = v
                else
                    term.setCursorPos(1, DrawUpto + 2)
                    term.write(v)
                end
            end
        end
        if SearchOffset > DrawUpto - 1 then
            SearchOffset = DrawUpto - 1
        end
    end

end

while true do
    UpdateScreen()
    Event, Output, Output2, Output3, Output4 = os.pullEvent()
    if Event == "char" then
        TextSearching = TextSearching .. Output
        SearchOffset = 0
    elseif Event == "key" then
        if Output == keys.backspace then
            TextSearching = string.sub(TextSearching, 1, #TextSearching - 1)
            SearchOffset = 0
        elseif Output == keys.enter then
            --start app
            --open_new_app <name> <path> <order> <WindowMode>
            print(SelectedApp)
            coroutine.yield("open_new_app",SelectedApp,"UserData/Apps/"..SelectedApp.."/startup.lua",1,"1")
            error("",-1)
        elseif Output == keys.delete then
            error("",-1)
        elseif Output == keys.up then
            SearchOffset = SearchOffset - 1
            if SearchOffset < 0 then
                SearchOffset = 0
            end
        elseif Output == keys.down then
            SearchOffset = SearchOffset + 1
        end
    end
end

