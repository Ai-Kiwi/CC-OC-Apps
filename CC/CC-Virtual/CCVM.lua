local args = {...}
LocOFVMFiles = "/VM/"
FsInVM = {}
OSInVM = {}
IoInVM = {}
RomLoc = "rom/"
VmCoreFileName = "BootVM"
VmOutputFile = "/VMHOSTFILES/VMOUTPUT"
VmSettingsFile = "/VMHOSTFILES/VmSettings"

shell.run("delete " .. VmCoreFileName)
shell.run("pastebin get wDxMgi3p " .. VmCoreFileName)


function clearchat()
term.clear()
term.setCursorPos(1,1)
end


function LoadSettings()
    settings.load(VmSettingsFile)
    loadStartupFIle = settings.get("loadStartupFIle")
    LogFSCommands = settings.get("LogFSCommands")
    UseComputerIDFromSettings = settings.get("UseComputerIDFromSettings")
    ComputerIDFromSettings = settings.get("ComputerIDFromSettings")
    settings.save(VmSettingsFile)
    if not loadStartupFIle then loadStartupFIle = "yes" end
    if not LogFSCommands then LogFSCommands = "no" end 
    if not UseComputerIDFromSettings then UseComputerIDFromSettings = "no" end
    if not ComputerIDFromSettings then ComputerIDFromSettings = 0 end
    ComputerIDFromSettings = tonumber(ComputerIDFromSettings)
    settings.load(VmSettingsFile)
    settings.set("LogFSCommands", LogFSCommands)
    settings.set("loadStartupFIle", loadStartupFIle)
    settings.set("UseComputerIDFromSettings", UseComputerIDFromSettings)
    settings.set("ComputerIDFromSettings", ComputerIDFromSettings)
    settings.save(VmSettingsFile)
end



--to simulate
--disk libary
--  https://tweaked.cc/module/disk.html
--http libary
--  https://tweaked.cc/module/http.html
--io libary
--  https://tweaked.cc/module/io.html
--os liabry (alot of fun stuff to fake lol)
--  https://tweaked.cc/module/os.html
--pocket libary
--  https://tweaked.cc/module/pocket.html
--redstone libary
--  https://tweaked.cc/module/redstone.html
--shell libary (not that import beacuase i've already done fs)
--  https://tweaked.cc/module/shell.html

local function LoadVM()

local function commandHasBennRun(commandName,CommandValueOne,CommandValueTwo)
    if LogFSCommands == "yes" then
        if CommandValueTwo == nil then
            CommandValueTwo = " "
        end
        OutputFile = FsInVM.open(VmOutputFile,"a") -- "a" stands for append it will add it to the end of the file instead of erasing the file
        OutputFile.writeLine(commandName .. " " .. CommandValueOne .." " .. CommandValueTwo)
        OutputFile.close() -- if you dont close the file it will not save, and other problems could occur.
    end
end


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

term.clear()
term.setCursorPos(1,1)
print("CC:VM 1.0")
if loadStartupFIle == "yes" then
    if fs.exists("startup.lua") then
    shell.run("startup.lua")
    end
    if fs.exists("startup") then
    shell.run("startup")
    end
end

end



LoadSettings()
clearchat()
print("CC:VM luancher")
print("1 : load vm")
print("2 : settings for vm")
answer = read()
if answer == "1" then
    clearchat()
    print("VM Name?")
    fs.makeDir(LocOFVMFiles)
    term.setCursorPos(1,3)
    print("installed vms")
    local VmList = fs.list("/VM/")
    for _, file in ipairs(VmList) do
    print(file)
    end
    term.setCursorPos(1,2)
    answer = read()
    LocOFVMFiles = LocOFVMFiles .. answer .. "/" 
    fs.makeDir(LocOFVMFiles)
    LoadVM()
elseif answer == "2" then
    shell.run("edit " .. VmSettingsFile)
end