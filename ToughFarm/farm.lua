--1.13
--auto update
local args = {...}
local VERSION = "1.13"
term.clear()
term.setCursorPos(1,1)
if args[1] == "install" then
    VERSION = "installing"
end 
--to install
-- wget run https://raw.githubusercontent.com/Ai-Kiwi/CC-Apps/main/ToughFarm/farm.lua install
print("trying to update... ")
local request = http.get("https://raw.githubusercontent.com/Ai-Kiwi/CC-Apps/main/ToughFarm/farm.lua")
if request then
    local VerText = request.readLine()
    local Data = request.readAll()
    if Data ~= nil then
        if VerText ~= "--" .. VERSION then
            local file = fs.open("startup.lua","w")
            if file ~= nil then
                file.write(VerText .. "\n" .. Data)
                print("successfully updated")
                file.close()
                request.close()
                os.reboot()
            end
        else
            print("no updates needed")
        end
    end
    request.close()
end
print("")


print("Ai Kiwi Farmer - " .. VERSION)
local function Main()
    --loop through all items in list
    for i=1, 27 do
        food = peripheral.wrap("left")
        food.pullItems("down",i)
    end
end

--make it so after 10m they auto update
for i=1, 40 do
    pcall(Main)
    os.sleep(15)
end
os.reboot()