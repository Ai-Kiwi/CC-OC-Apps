local MoniterX, MoniterY = term.getSize()
local OldMoniterX, OldMoniterY = MoniterX, MoniterY
local RootTerm = term.native()
term.TrueNative = term.native()
local DoubbleBuffer = window.create(RootTerm, 1, 1, MoniterX, MoniterY,false)
local ProgramUUIDupto = 0
local SelectedApp = 0
local SelectedOutsideOfApp = false
local SelectedOutsideOfAppResizeMode = nil
local SelectedOutSideStartXOffset = 0
local SelectedOutSideStartYOffset = 0
local EventsOnlySelectedAppGets = {}
EventsOnlySelectedAppGets["char"] = true
EventsOnlySelectedAppGets["key"] = true
EventsOnlySelectedAppGets["key_up"] = true
EventsOnlySelectedAppGets["mouse_click"] = true
EventsOnlySelectedAppGets["mouse_drag"] = true
EventsOnlySelectedAppGets["mouse_scroll"] = true
EventsOnlySelectedAppGets["mouse_up"] = true
EventsOnlySelectedAppGets["paste"] = true
local CpuUsage = 0
local PastCPUUsage = {}







--RootTerm = term.native()
--please note this os is made to be used solely to run apps and manage things as little stuff as possable should be in here.
local AppsRunnning = {}
local WindowManagerSettings = {}
--ganna make this open it alter
WindowManagerSettings.WindowBorderColor = colors.blue

--TODO:
--make only selected app use mouse and keboard
--make it so you can resize the window
--make sure that if a app has custem flags such as waiting for timer then wait for it
--run term_resize when windows move 
--fix apps not updating untill you click on them
--add term.resize as a thing that can be called to apps
--add api for commands so that its reasyer so for insttance ToasterOS.GetScreenSize()
--add not update feature (maybe in settings app?)
--add custem boot menu

--task manager
    --kill apps
    --cpu uasage of apps
    --
 
local function LoadTextInMiddleOfScreen(TextToWrite,TextToWriteBelow)
    term.clear()
    --makes a noice start prompt using auto scaled text 
    local MoniterX, MontierY = term.getSize()

    local BigFont = require("libs.bigfont")


    local TextSizeX = #TextToWrite * 3
    local TextSizeY = 2

    term.setCursorPos(math.floor((MoniterX / 2) - (TextSizeX / 2)),math.floor((MontierY / 2) - (TextSizeY / 2)))

    BigFont.bigPrint(TextToWrite)
    if TextToWriteBelow then
        term.setCursorPos(math.floor((MoniterX / 2) - (#TextToWriteBelow / 2)),math.floor((MontierY / 2) + 1 + (TextSizeY / 2)))
        print(TextToWriteBelow)
    end
end


local function UpdateDoubbleBuffer()
    DoubbleBuffer.reposition(1,1,MoniterX,MoniterY)
    DoubbleBuffer.setVisible(true)
    DoubbleBuffer.redraw()
    DoubbleBuffer.setVisible(false)

end

local function StartShutDown(DoRestart,Force)
    --cleans up after running os
    term.redirect(RootTerm)

    if DoRestart then
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.blue)
        LoadTextInMiddleOfScreen("Restarting","Please Wait...")
        os.sleep(5)
        os.reboot()
    else
        print("Shutting Down")
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.blue)
        LoadTextInMiddleOfScreen("Shutting Down","Please Wait...")
        os.sleep(5)
        os.shutdown()
    end



end



local function CreateNewApp(AppName,AppPath,AppOrder,WindowMode)
    local function NewAppCoroutine()
        shell.run(AppPath)
    end
    ProgramUUIDupto = ProgramUUIDupto + 1

    local ShowWindow = true
    if WindowMode == "0" then
        ShowWindow = false
    end

    if WindowMode == nil then
        WindowMode = "1"
    end

    local NewWindow = window.create(DoubbleBuffer,5,3,30,20,ShowWindow)
    local NewCoroutine = coroutine.create(NewAppCoroutine)
    local App = {}
    App.Name = AppName
    App.Path = AppPath
    App.Order = AppOrder
    App.Coroutine = NewCoroutine
    local WindowData = {}
    WindowData.WindowObject = NewWindow
    WindowData.x = 5
    WindowData.y = 3
    WindowData.width = 30
    WindowData.height = 20
    --window modes
    -- 0: completely hidden
    -- 1: normal (menu)
    -- 2: fullscreen
    -- 3: boarderless window
    WindowData.WindowMode = WindowMode
    App.Window = WindowData
    App.UUID = ProgramUUIDupto
    App.CoroutineTime = 0
    table.insert(AppsRunnning, App)

    os.queueEvent("app_start",App.UUID)
end

local function ConvertUUIDToApp(UUID)
    for k,v in pairs(AppsRunnning) do
        if v.UUID == UUID then
            return v
        end
    end
end
local function KillUUID(UUID)
    for k,v in pairs(AppsRunnning) do
        if v.UUID == UUID then
            table.remove(AppsRunnning,k)
        end
    end
end





--CreateNewApp("shell","rom/programs/shell.lua",1,1)

--CreateNewApp("worm","rom/programs/worm.lua",1,2)
CreateNewApp("KiwiOS","KiwiOS/KiwiOS.lua",-100,"0")




while #AppsRunnning > 0 do
    local TempCpuUsage = os.epoch("utc")
    term.redirect(RootTerm)
    MoniterX, MoniterY = term.getSize()
    term.redirect(DoubbleBuffer)
    UpdateDoubbleBuffer()
    local PullEventTable = table.pack(os.pullEventRaw())
    
    


    --i need to fix doing this every time its really not good to resort every fucking time
    table.sort(AppsRunnning, function(a,b) return a.Order > b.Order end)

    
    --look through apps backwards and see what one you clicked on frist then pick that as the selected app if you clicked with the mouse
    if PullEventTable[1] == "mouse_click" then
        for k,v in pairs(AppsRunnning) do
            if v.Window.WindowMode == "0" then
            else
                --test if they are clicking on program
                if PullEventTable[3] >= v.Window.x - 1 and PullEventTable[3] <= v.Window.x + v.Window.width and PullEventTable[4] >= v.Window.y - 1 and PullEventTable[4] <= v.Window.y + v.Window.height then
                    SelectedApp = v.UUID
                    SelectedOutsideOfApp = false
                    SelectedOutsideOfAppResizeMode = nil
                    --looks if they are clicking on the app
                    if PullEventTable[3] >= v.Window.x and PullEventTable[3] <= v.Window.x + v.Window.width - 1 and PullEventTable[4] >= v.Window.y and PullEventTable[4] <= v.Window.y + v.Window.height - 1 then
                        break
                    end
                    --if they are not clicking on the app 

                    --if they are clicking on the close butten
                    if PullEventTable[3] == v.Window.x + v.Window.width - 1 and PullEventTable[4] == v.Window.y - 1 then
                        table.remove(AppsRunnning,k)
                        break
                    end

                    --looks if they are clicking on the top row
                    if PullEventTable[3] >= v.Window.x and PullEventTable[3] <= v.Window.x + v.Window.width - 1 and PullEventTable[4] == v.Window.y - 1 then
                        SelectedOutsideOfApp = true
                        SelectedOutsideOfAppResizeMode = nil
                        SelectedOutSideStartXOffset = PullEventTable[3] - v.Window.x
                        SelectedOutSideStartYOffset = PullEventTable[4] - v.Window.y
                        break
                    end



                    --we now know they are trying to resize the window
                    --so now the quastion is just are they resizing the x or the y or both
                    SelectedOutsideOfApp = true
                    SelectedOutsideOfAppResizeMode = ""
                    --if they are clickin on top or bottem row
                    if v.Window.y - 1 == PullEventTable[4] or v.Window.y + v.Window.height == PullEventTable[4] then
                        SelectedOutsideOfAppResizeMode = SelectedOutsideOfAppResizeMode .. "y"
                        SelectedOutSideStartXOffset = PullEventTable[3] - v.Window.x
                        SelectedOutSideStartYOffset = PullEventTable[4] - v.Window.y
                        
                    end
                    --if they are clicking on the left or right row
                    if v.Window.x - 1 == PullEventTable[3] or v.Window.x + v.Window.width == PullEventTable[3] then
                        SelectedOutsideOfAppResizeMode = SelectedOutsideOfAppResizeMode .. "x"
                        SelectedOutSideStartXOffset = PullEventTable[3] - v.Window.x
                        SelectedOutSideStartYOffset = PullEventTable[4] - v.Window.y
                        
                    end
                    

                    break

                end
            end
        end
        
    end

    --things to help the computer incase of proleam like emergancy commands, task manager and cmd.
    if PullEventTable[1] == "key" then
        if PullEventTable[2] == keys.home then
            CreateNewApp("taskmanager","KiwiOS/sysapp/taskmanager.lua",50,"1")   
        end
        if PullEventTable[2] == keys.delete then
            CreateNewApp("shell","rom/programs/shell.lua",1,"1")
        end
    end

    

    --sort the table by order
    table.sort(AppsRunnning, function(a,b) return a.Order < b.Order end)
    
    
    

    --loop through apps and run them
    for k,v in pairs(AppsRunnning) do
        --handles moving window
        if PullEventTable[1] == "mouse_drag" and SelectedApp == v.UUID then
            if v.Window.WindowMode == "1" and SelectedOutsideOfApp then
                if SelectedOutsideOfAppResizeMode == nil then
                    v.Window.x = PullEventTable[3] - SelectedOutSideStartXOffset
                    v.Window.y = PullEventTable[4] - SelectedOutSideStartYOffset
                else
                    if string.find(SelectedOutsideOfAppResizeMode,"x") then
                        v.Window.width = PullEventTable[3] - v.Window.x 
                        if v.Window.width < 5 then
                            v.Window.width = 5
                        end
                    end
                    if string.find(SelectedOutsideOfAppResizeMode,"y") then
                        v.Window.height = PullEventTable[4] - v.Window.y
                        if v.Window.height < 5 then
                            v.Window.height = 5
                        end
                    end
                end
            end
        end
        --make sure selected app is infront
        if v.UUID == SelectedApp then
            if v.Order == 0 then
                v.Order = 1
            end
        else
            if v.Order == 1 then
                v.Order = 0
            end
        end


        --makes sure apps that are max size stay max size
        if  v.Window.WindowMode == "2" then
            v.Window.WindowObject.reposition(1,1,MoniterX,MoniterY)
            v.Window.x = 1
            v.Window.y = 1
            v.Window.width = MoniterX
            v.Window.height = MoniterY
        else
            v.Window.WindowObject.reposition(v.Window.x,v.Window.y,v.Window.width,v.Window.height)
        end
        
        local AppLoopNumber = 0
        local function LoopCoroutine(InputTable,MoveAppMousePos)
            AppLoopNumber = AppLoopNumber + 1


            NewInputTable = InputTable
            if MoveAppMousePos == true then
                if NewInputTable[1] == "mouse_click" then
                    NewInputTable[3] = NewInputTable[3] - v.Window.x + 1
                    NewInputTable[4] = NewInputTable[4] - v.Window.y + 1

                elseif NewInputTable[1] == "mouse_drag" then
                    NewInputTable[3] = NewInputTable[3] - v.Window.x + 1
                    NewInputTable[4] = NewInputTable[4] - v.Window.y + 1

                elseif NewInputTable[1] == "mouse_scroll" then
                    NewInputTable[3] = NewInputTable[3] - v.Window.x + 1
                    NewInputTable[4] = NewInputTable[4] - v.Window.y + 1

                elseif NewInputTable[1] == "mouse_up" then
                    NewInputTable[3] = NewInputTable[3] - v.Window.x + 1
                    NewInputTable[4] = NewInputTable[4] - v.Window.y + 1

                end
            end
            
            --look if montior has been resized
            if MoniterX ~= OldMoniterX or MoniterY ~= OldMoniterY then
                os.queueEvent("term_resize")
                OldMoniterX = MoniterX
                OldMoniterY = MoniterY
            end


            local status, Output, Output2, Output3, Output4, Output5 = coroutine.resume(v.Coroutine, unpack(NewInputTable))
            
            if Output == nil then
                return
            end


            if Output == "app_list" then
                local NewAppsRunning = {}
                for k,v in pairs(AppsRunnning) do
                    NewAppsRunning[k] = {}
                    NewAppsRunning[k].Path = v.Path
                    NewAppsRunning[k].Name = v.Name
                    NewAppsRunning[k].UUID = v.UUID
                    NewAppsRunning[k].Order = v.Order
                    NewAppsRunning[k].Window = {}
                    NewAppsRunning[k].Window.x = v.Window.x
                    NewAppsRunning[k].Window.y = v.Window.y
                    NewAppsRunning[k].Window.width = v.Window.width
                    NewAppsRunning[k].Window.height = v.Window.height
                    NewAppsRunning[k].Window.WindowMode = v.Window.WindowMode




                    
                end
                LoopCoroutine({"app_list_result",NewAppsRunning})
            elseif Output == "SYSINFO" then
                local SYSINFO = {}
                SYSINFO.CpuUsage = CpuUsage
                SYSINFO.PastCPUUsage = PastCPUUsage

                LoopCoroutine({"SYSINFO_result",SYSINFO})
                
            elseif Output == "kill_app" then
                --kill_app <UUID>
                KillUUID(Output2)
                LoopCoroutine({"killed_app",Output2})

            elseif Output == "get_screen_size" then
                --GetScreenSize
                LoopCoroutine({"got_screen_size",MoniterX,MoniterY})
            elseif Output == "set_window_size" then
                -- setWindowSize <width> <height>

                --cheek they are both numbers
                if type(Output2) == "number" and type(Output3) == "number" then
                    v.Window.width = Output2
                    v.Window.height = Output3
                    v.Window.WindowObject.reposition(v.Window.x,v.Window.y,v.Window.width,v.Window.height)
                    LoopCoroutine({"set_window_size",Output2,Output3})
                else
                    LoopCoroutine({"Failed_set_window_size"})
                end
                
            elseif Output == "set_window_position" then
                -- setWindowPos <X> <Y>

                --cheek they are both numbers
                if type(Output2) == "number" and type(Output3) == "number" then
                    v.Window.x = Output2
                    v.Window.y = Output3
                    v.Window.WindowObject.reposition(v.Window.x,v.Window.y,v.Window.width,v.Window.height)
                    LoopCoroutine({"set_window_position",Output2,Output3})
                else
                    LoopCoroutine({"Failed_set_window_position"})
                end

            elseif Output == "open_new_app" then
                -- open_new_app <name> <path> <order> <WindowMode>

                --cheek they are all correct
                if type(Output2) == "string" and type(Output3) == "string" and type(Output4) == "number" and type(Output5) == "string" then
                    CreateNewApp(Output2,Output3,Output4,Output5)
                    LoopCoroutine({"created_new_app",Output2})
                else
                    LoopCoroutine({"Failed_create_new_app"})
                end 

            else
                return
            end

            

        end
        
        --runs code
        term.native = v.Window.WindowObject
        term.redirect(v.Window.WindowObject)
        if coroutine.status(v.Coroutine) == "dead" then
            table.remove(AppsRunnning, k)
        else
            local TimeAppTook = os.epoch("utc")
            --looks if what its running should only be ran by that one program
            if EventsOnlySelectedAppGets[PullEventTable[1]] == true then
                if v.UUID == SelectedApp then
                    LoopCoroutine(PullEventTable,true)
                end
            else
                LoopCoroutine(PullEventTable,true)
            end
            TimeAppTook = os.epoch("utc") - TimeAppTook
            if not v == nil then
            v.CoroutineTime = TimeAppTook
            end
        end
        term.native = DoubbleBuffer
        
    end
    term.redirect(DoubbleBuffer)
    --runs the app that draws app

    os.run({},"KiwiOS/windowManager.lua",AppsRunnning, WindowManagerSettings, SelectedApp)
    CpuUsage = os.epoch("utc") - TempCpuUsage
    table.insert(PastCPUUsage,1,CpuUsage)
    while #PastCPUUsage > 25 do
        PastCPUUsage[#PastCPUUsage] = nil
    end
end


StartShutDown()




