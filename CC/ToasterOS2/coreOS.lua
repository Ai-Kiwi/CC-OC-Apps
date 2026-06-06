local function VmWholeApp(PermLevel,progeamBootedName)
    RomLoc = "rom"
    LocOFVMFiles = "vm/progeams/" .. progeamBootedName
    local function LoadNewFsSystem()
        --fs.list
        FsInVM.list = fs.list
        local function ListInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("ListInVM",path)
            return FsInVM.list(NewPath)
        end
        fs.list = ListInVM

        --fs.getname
        FsInVM.getName = fs.getName
        local function GetNameInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("GetNameInVM",path)
            return FsInVM.getName(NewPath)
        end
        fs.getName = GetNameInVM


        --fs.getDir
        FsInVM.getDir = fs.getDir
        local function GetDirInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("GetDirInVM",path)
            return FsInVM.getDir(NewPath)
        end
        fs.getDir = GetDirInVM

        FsInVM.getSize = fs.getSize
        local function getSizeInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("getSizeInVM",path)
            return FsInVM.getSize(NewPath)
        end
        fs.getSize = getSizeInVM

        FsInVM.exists = fs.exists
        local function existsInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("existsInVM",path)
            return FsInVM.exists(NewPath)
        end
        fs.exists = existsInVM

        FsInVM.isDir = fs.isDir
        local function isDirInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("isDirInVM",path)
            return FsInVM.isDir(NewPath)
        end
        fs.isDir = isDirInVM

        FsInVM.isReadOnly = fs.isReadOnly
        local function isReadOnlyInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("isReadOnlyInVM",path)
            return FsInVM.isReadOnly(NewPath)
        end
        fs.isReadOnly = isReadOnlyInVM


        FsInVM.makeDir = fs.makeDir
        local function makeDirInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("makeDirInVM",path)
            return FsInVM.makeDir(NewPath)
        end
        fs.makeDir = makeDirInVM

        FsInVM.getDrive = fs.getDrive
        local function getDriveInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("getDriveInVM",path)
            return FsInVM.getDrive(NewPath)
        end
        fs.getDrive = getDriveInVM

        FsInVM.getFreeSpace = fs.getFreeSpace
        local function getFreeSpaceInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("getFreeSpaceInVM",path)
            return FsInVM.getFreeSpace(NewPath)
        end
        fs.getFreeSpace = getFreeSpaceInVM

        FsInVM.delete = fs.delete
        local function deleteInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("deleteInVM",path)
            return FsInVM.delete(NewPath)
        end
        fs.delete = deleteInVM

        FsInVM.find = fs.find
        local function findInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("findInVM",path)
            return FsInVM.find(NewPath)
        end
        fs.find = findInVM

        FsInVM.getCapacity = fs.getCapacity
        local function getCapacityINVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("getCapacityINVM",path)
            return FsInVM.find(NewPath)
        end
        fs.getCapacity = getCapacityINVM

        FsInVM.attributes = fs.attributes
        local function attributesINVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("attributesINVM",path)
            return FsInVM.find(NewPath)
        end
        fs.attributes = attributesINVM


        FsInVM.move = fs.move
        local function moveINVM(path, dest)
            newdest = LocOFVMFiles .. dest
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            INROM = string.find(dest, RomLoc )
            if INROM then
                newdest = dest
            end
            commandHasBennRun("moveINVM",path,dest)
            return FsInVM.find(NewPath, newdest)
        end
        fs.move = moveINVM

        FsInVM.copy = fs.copy
        local function copyINVM(path, dest)
            newdest = LocOFVMFiles .. dest
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            INROM = string.find(dest, RomLoc )
            if INROM then
                newdest = dest
            end
            commandHasBennRun("copyINVM",path,dest)
            return FsInVM.find(NewPath, newdest)
        end
        fs.copy = copyINVM


        FsInVM.open = fs.open
        local function openINVM(path, mode)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            commandHasBennRun("openINVM",path,mode)
            return FsInVM.open(NewPath, mode)
        end
        fs.open = openINVM
    end

    --need to fix shutdown
    --need to fix reboot
    local function LoadOSSystem()
        
        --shutdown reboots computer into outside of vm
        --os.shutdown
        OSInVM.shutdown = os.shutdown
        local function ShutdownInVM()
            commandHasBennRun("Shutdown")
            return OSInVM.reboot
        end
        os.shutdown = ShutdownInVM

        --reboot restarts vm
        --os.reboot
        OSInVM.reboot = os.reboot
        local function rebootInVM()
            commandHasBennRun("reboot")
            return OSInVM.reboot
        end
        os.reboot = rebootInVM

        --os.getComputerID
        OSInVM.getComputerID = os.getComputerID
        local function getComputerIDInVM()
            commandHasBennRun("getComputerID")
            ComputerID = OSInVM.getComputerID
            if UseComputerIDFromSettings == "yes" then
                ComputerID = ComputerIDFromSettings
            end
            return ComputerID
        end
        os.getComputerID = getComputerIDInVM

        --os.computerID
        OSInVM.computerID = os.computerID
        local function computerIDInVM()
            commandHasBennRun("computerID")
            ComputerID = OSInVM.computerID
            if UseComputerIDFromSettings == "yes" then
                ComputerID = ComputerIDFromSettings
            end
            return ComputerID
        end
        os.computerID = computerIDInVM


        --os.getComputerLabel
        OSInVM.getComputerLabel = os.getComputerLabel
        local function getComputerLabelInVM()
            commandHasBennRun("getComputerLabel")
            return OSInVM.getComputerLabel
        end
        os.getComputerLabel = getComputerLabelInVM

        --os.computerLabel
        OSInVM.computerLabel = os.computerLabel
        local function computerLabelInVM()
            commandHasBennRun("computerLabel")
            return OSInVM.computerLabel
        end
        os.computerLabel = computerLabelInVM

        -- os.clock
        OSInVM.clock = os.clock
        local function clockInVM()
            commandHasBennRun("clock")
            return OSInVM.clock
        end
        os.clock = clockInVM


    end

    local function LoadioSystem()

        --io.open
        IoInVM.ioOpen = io.open
        local function IoOpenInVM(path)
            NewPath = LocOFVMFiles .. path
            INROM = string.find(path, RomLoc )
            if INROM then
                NewPath = path
            end
            return IoInVM.ioOpen(NewPath)
        end
        io.open = IoOpenInVM

    end
    LoadNewFsSystem()
    LoadOSSystem()
    -- removed beacuse bugs you know  -- LoadioSystem()

end

function recaulateSize(InputScreenX,InputScreenY,Inputhight,Inputwidth)
    screenX = InputScreenX
    screenY = InputScreenY
    screenWidth = Inputwidth
    screenHight = Inputhight

end

function StartupMainOS()
    local serverID = 42
    local SideDiskOn = "right"
    local BackgroundTerm = term
    
    local screenX = 2
    local screenY = 2
    local screenWidth = 5
    local screenHight = 5
    
    --define computer values
    recaulateSize(2,2,15,25)
    local screenXsize , screenYsize = term.getSize()
    local middleXscreen = math.floor(screenXsize / 2)
    local middleYscreen = math.floor(screenYsize / 2)
    local logoImage = paintutils.loadImage("systemFiles/images/Logo")
    
    --setup screen windows
    BackgroundTerm = term.current()
    local gamewindow = window.create(term.current(),screenX,screenY,screenWidth,screenHight)
    gamewindow.setVisible(false)
    
end


function DrawBackground()
    term.clear()
    paintutils.drawFilledBox(1, 1, screenXsize, screenYsize, colours.blue)
    paintutils.drawImage(logoImage, middleXscreen - 5, middleYscreen - 3)

end

function RunApp(AppLoc,PermLoadLevel)
    paintutils.drawBox(screenX - 1, screenY - 1, screenX + screenWidth, screenY + screenHight, colours.yellow)
    term.setCursorPos(screenX, screenY - 1)
    term.setTextColour(colors.black)
    term.write(fs.getName(AppLoc))
    paintutils.drawPixel(screenX + screenWidth, screenY - 1, colors.red)
    paintutils.drawPixel(screenX + screenWidth - 1, screenY - 1, colors.green)
    --moves mouse click locastions

    --local oldPER = os.pullEventRaw

    function windowmousefix(filter)   
            result = {}
            result = {oldPER(filter)}
            if result[1] == "mouse_click" then
                windowsXOffset = screenX - 1
                windowsYOffset = screenY - 1
                windowsXOffset = windowsXOffset / 3
                windowsYOffset = windowsYOffset / 3

                result[3] = result[3] - windowsXOffset
                result[4] = result[4] - windowsYOffset
            end 
            --print(result[1])
            --if result[1] then print(result[1]) end
            --if result[2] then print(result[2]) end
            --if result[3] then print(result[3]) end
            return unpack(result)
    end
    --os.pullEventRaw = windowmousefix
    term.redirect(gamewindow)
    gamewindow.setVisible(true)
    gamewindow.redraw()
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
    shell.run(AppLoc)
    --os.pullEventRaw = oldPER
    os.sleep(0.5)
end

function CloseProgeamBackgroundLoop()
    local closeApp = true
    while closeApp do
        local event, key = os.pullEvent( "key" )
        if key == keys.tab then
            closeApp = false
            print("e")
        end
    end

end



--load app has perm level
--perm levels
--1 : full root perms over whole software
--2 : everything but core files
--3 : fully sandboxed but can acses disk drive
--4 : fully sandboxed
--5 : can't reboot phone
--6 : can't do anytihng
function LoadApp(AppLoc,PermLevel)
    DrawBackground()
    RunApp(AppLoc,PermLevel)
    --after app finishs
    gamewindow.setVisible(false)
    term.redirect(BackgroundTerm)
    
    DrawBackground()
    DrawOSMainMenu()
end

function drawButten(InputOffset,InputColor,LetterColor,LetterText,startFromRight,DrawOnButtem)
    if DrawOnButtem then
        hight = screenYsize
    else
        hight = 1
    end

    if startFromRight then
        paintutils.drawPixel(screenXsize - InputOffset,hight, InputColor)
        term.setCursorPos(screenXsize - InputOffset,hight)
    else
        paintutils.drawPixel(InputOffset + 1,hight,InputColor)
        term.setCursorPos(InputOffset + 1,hight)
    end
    
    term.setTextColor(LetterColor)
    term.write(LetterText)
end


AppLoc = {}

function DrawOSMainMenu()
    term.clear()
    DrawBackground()
    paintutils.drawLine(1,screenYsize,screenXsize,screenYsize, colors.yellow)
    
    ProgramsOnPc = fs.list("systemFiles/programs")

    for i=1, #ProgramsOnPc do
        firstLetter = ProgramsOnPc[i]:sub(1,1)
        --to the left
        drawButten(i - 1,colors.orange,colors.white,firstLetter,false,true)
    end
    
    
    
    
    HasDiskInserted = disk.isPresent(SideDiskOn)
    --action bar
    if HasInternet then
        drawButten(0,colors.greeen,colors.white,"I",false,false)
    else
        drawButten(0,colors.red,colors.white,"I",false,false)
    end
    if HasDiskInserted then
        drawButten(1,colors.greeen,colors.white,"D",false,false)
    else
        drawButten(1,colors.red,colors.white,"D",false,false)
    end
end

function OpenUserInstalledProgeams()
    
end

function PopUp(text,UseInput)
    DrawBackground()
    paintutils.drawBox(middleXscreen - 12,middleYscreen - 3, middleXscreen + 13,middleYscreen + 4, colors.black)
    paintutils.drawFilledBox(middleXscreen - 11,middleYscreen - 2, middleXscreen + 12,middleYscreen + 3, colors.white)
    paintutils.drawLine(middleXscreen - 9,middleYscreen + 1, middleXscreen + 10,middleYscreen + 1, colors.black)

    term.setCursorPos(middleXscreen - 10,middleYscreen - 1)
    term.setTextColor(colors.black)
    term.setBackgroundColour(colors.lightGray)
    term.write(text)
    if UseInput then
        term.setTextColor(colors.white)
        term.setBackgroundColour(colors.black)
        term.setCursorPos(middleXscreen - 9,middleYscreen + 1)
        output = read()
    else
        term.setTextColor(colors.white)
        term.setBackgroundColour(colors.cyan)
        term.setCursorPos(middleXscreen - 9,middleYscreen + 1)
        term.write("Yeah")
        term.setCursorPos(middleXscreen - 4,middleYscreen + 1, colors.cyan)
        term.write("Nope")
        while true do
            local event, p1, p2, p3 = os.pullEvent("mouse_click")
            if p3 == middleYscreen + 1 then
                if p2 > middleXscreen - 10 and p2 < middleXscreen - 5 then
                    return true
                end
                if p2 > middleXscreen - 5 and p2 < middleXscreen then
                    return false
                end
            end
        end
    end
    DrawBackground()
    return output
end

function MainOsLoop()
    while true do
        DrawOSMainMenu()
        local event, p1, p2, p3 = os.pullEvent()
        if event == "mouse_click" then
            if p1 == 1 then -- cheeks if left click
                if p3 == screenYsize then -- cheeks if its on taskbar
                    if p2 == screenXsize then
                        OpenUserInstalledProgeams()
                    elseif not (ProgramsOnPc[p2] == nil) then
                        LoadApp("systemFiles/programs/" .. ProgramsOnPc[p2],4)
                    end
                end
            end
        end
        if event == "disk" then
            RunDisk = PopUp("Boot from DVD?",false)
            if RunDisk then
                LoadApp("disk/startup",4)
            end
        end
    end
end

local HasInternet = false
local function InternetCheek()
    while true do 
        rednet.send(serverID,"ping","Toaster2ServerMessage")
        senderID, Message, ServerDistance = rednet.receive("Toaster2ServerMessage",2)
        if Message == nil then
            HasInternet = false
        else
            HasInternet = true
        end
        HasDiskInserted = disk.isDiskPresent()
        wait(5) 
    end
end

StartupMainOS()


parallel.waitForAny(MainOsLoop(),InternetCheek())

--TODO:
-- add file explorer
-- add settings
-- add files on desktop
-- add web browser
-- add disc player
-- add moniter support
-- add stoarge app
-- add noficastion panel

--use pastebin.com/gsFrNjbt for sha256

-- windows os notes
-- use window api for drawing progeams
-- seprate file locastions
-- add phone vm
-- draw outline for windows
-- have taskbar
-- have muli moniter support
-- run muaplue progeams at once

--add privalges for apps
--add reboot run (run a command threw shell after reboot)
--open hotkey with keybinding


--websites end with there thing with is sent to your privider with redricts to your website
--websites use protacal for witch website
-- website uses custem launge 