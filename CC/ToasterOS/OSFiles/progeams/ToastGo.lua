LogoText = "ToastAmon v1.12"


--clear chat function
function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end



--area todo
-- x -450 - 1250
-- z 1000 - 200

--values for modufiers
quailtyLevels = {"crapy", "low quilty", "alright quilty", "great quilty", "Extreme quilty"}
quailtyLevelsValues = {-20,-10,5,20,50}

cripyness = {"soggy", "soft", "hard", "cruchy", "crispy", "Brick soild"}
crispnessValues = {-25, 0, 5, 15, 25, 50}

RandomModifier = {"moldy", "nomeal", "magical", "Holy"}
RandomModifierValues = {-10, 0, 10, 15}

BreadTypes = {"White bread", "Garlic bread", "Wheat bread", "Rye bread", "Ciabatta bread", "Venina bread", "Pizza bread", "Whole grain bread" , "Brick bread", "Sourdough bread", "Brioche bread", "Holy Unleavened bread", "Crêpe", "Pretzels", "Pandoro"}
BreadTypesValues = {0, 15, 0, 5, 25, 25, 35, 5, 35, 5, 15, 5, 25, 5, 0}


TodaysDate = (tonumber(os.date("%d")) * tonumber(tonumber(os.date("%m"))) * tonumber(os.date("%Y")))
math.randomseed(os.time())

function NewSave()
    ClearChat()
    print("you appear to be new here")
    answer = read()
    print("what do you wanna be called")
    Username = read()
    ClearChat()
    print("Welcome to ToastAmon. your goal is to get as much toast as you can")
    print("you can see the ammounit in a ~150 block radius")
    print("when you go withn 50 blocks it will say how far away it is")
    print("when width 5 blocks it will start a fight!")
    print("goodluck!")
    answer = read()
    ClearChat()

    LastToastcatchToast =  0
    LastOnline = 1
    xp = 0
    level = 1
    Coins = 100
    NewToastSpots()
    SaveSaveFile()
end

function NewToastSpots()
    ToastMOBX = {}
    ToastMOBZ = {}
    for i=0, 25 do
        MakeNewToastLoc()
        table.insert(ToastMOBX,NewToastX)
        table.insert(ToastMOBZ,NewToastZ)
    end

end


function MakeNewToastLoc()
NewToastZ = math.random(800)
NewToastZ = NewToastZ + 200
NewToastX = math.random(1700)
NewToastX = NewToastX - 450
end


function SaveSaveFile()
    settings.load("ToasterGoSave")

    settings.set("LastCatch", LastToastcatchToast)
    settings.set("LastOnline", LastOnline)
    settings.set("xp", xp)
    settings.set("level", level)
    settings.set("coins", Coins)
    textutils.serialize(ToastMOBX)
    settings.set("ToastXPos", ToastMOBX)
    textutils.serialize(ToastMOBZ)
    settings.set("ToastYPos", ToastMOBZ)
    settings.set("username", Username)

    settings.save("ToasterGoSave")
end


function LoadSaveFile()
    settings.load("ToasterGoSave")

    LastToastcatchToast =  settings.get("LastCatch")

    LastOnline = settings.get("LastOnline")

    xp = settings.get("xp")

    level = settings.get("level")

    Coins = settings.get("coins")

    ToastMOBX = settings.get("ToastXPos")
    --textutils.unserialize(ToastMOBX)

    ToastMOBZ = settings.get("ToastYPos")
    --textutils.unserialize(ToastMOBZ)

    Username = settings.get("username")
    settings.save("ToasterGoSave")
end

function GenratePokeMon()
    FoundToastquailtyLevels  = math.random(1, #quailtyLevels)
    FoundToastcripyness = math.random(1, #cripyness)
    FoundToastRandomModifier = math.random(1, #RandomModifier)
    FoundToastBreadType = math.random(1, #BreadTypes)
    FoundToastquailtyLevelsValue = quailtyLevelsValues[FoundToastquailtyLevels]
    FoundToastcripynessValue = crispnessValues[FoundToastcripyness]
    FoundToastRandomModifierValue = RandomModifierValues[FoundToastRandomModifier]
    FoundToastBreadTypeValue = BreadTypesValues[FoundToastBreadType]
    FoundToastValue = (FoundToastquailtyLevelsValue + FoundToastcripynessValue + FoundToastRandomModifierValue + FoundToastBreadTypeValue)
    FoundToastName = (quailtyLevels[FoundToastquailtyLevels] .. " " .. cripyness[FoundToastcripyness] .. " " .. RandomModifier[FoundToastRandomModifier] .. " " .. BreadTypes[FoundToastBreadType])

end

function PokeMonCaught()
    ClearChat()
    term.setTextColor(colors.white)
    GenratePokeMon()
    print("you caught a " .. FoundToastName)
    print()
    print("quailty Value : " .. FoundToastquailtyLevelsValue)
    print("cripyness Value : " .. FoundToastcripynessValue)
    print("Random Modifer Value : " .. FoundToastRandomModifierValue)
    print("Bread Value : " .. FoundToastBreadTypeValue)
    print()
    print("Todal Value : " .. FoundToastValue)
    term.setTextColor(colors.green)
    print("")
    print("press enter to continue")
    answer = read()
    ClearChat()
    term.setTextColor(colors.green)
    print("+" .. 25 .. " xp")
    xp = xp + 25
    term.setTextColor(colors.yellow)
    print("+" .. FoundToastValue .. " Coins")
    Coins = FoundToastValue + Coins
    term.setTextColor(colors.green)
    if not (LastToastcatchToast == TodaysDate) then
        print("+50 coins (daily bonus)")
        Coins = Coins + 50
        print("+100 xp (daily bonus)")
        xp = xp + 100
        LastToastcatchToast = TodaysDate
    end
    SaveSaveFile()
    term.setTextColor(colors.green)
    print("")
    print("press enter to continue")
    answer = read()

end

function CheekForToast()
    ClosestDistance = 99999999
    ToastNearYou = 0
    PlayerVector = vector.new(PlayerX,PlayerZ)
    for i=1, #ToastMOBX do
        toastTestingX = ToastMOBX[i]
        toastTestingZ = ToastMOBZ[i]
        toastTestingvector = vector.new(toastTestingX,toastTestingZ)
        DistanceFromToast = toastTestingvector - PlayerVector
        ToastTestingDistance = math.abs(DistanceFromToast.length(DistanceFromToast))
        if ToastTestingDistance < ClosestDistance  then
            ClosestDistance = ToastTestingDistance
            NearestToastX = toastTestingX
            NearestToastZ = toastTestingZ
            NearestToastNumber = i
        end
        if ToastTestingDistance < 150 then
            ToastNearYou = ToastNearYou + 1
        end
    end
return ClosestDistance
end


function DrawMainMenu()
    ClearChat()
    term.setCursorPos(1,19)
    term.setTextColor(colors.white)
    print(PlayerX)
    print(PlayerZ)
    if (ToastNearYou > 0) then
        term.setTextColor(colors.red)
    else
        term.setTextColor(colors.white)
    end
    print(ToastNearYou)
    term.setCursorPos(1,1)
    term.setTextColor(colors.white)
    print(Username)
    term.setTextColor(colors.red)
    if DistanceToNearistToast < 50 then
        print(DistanceToNearistToast)
    end
    term.setTextColor(colors.yellow)

    print("Coins : " .. Coins)
    term.setTextColor(colors.green)
    print("Level : " .. level)
    print("xp : " .. xp .. PercentToNextLevel)
end

function CheekForToastFight()
    if DistanceToNearistToast < 5 then
        MakeNewToastLoc()
        ToastMOBX[NearestToastNumber] = NewToastX
        ToastMOBZ[NearestToastNumber] = NewToastZ
        ToastFight()
    end
end

function ToastFight()
    PokeMonCaught()
end



ClearChat()
term.setTextColor(colors.white)
print(LogoText)
print("1 : Play")
print("2 : Settings")
answer = read()
if (answer == "2") then
    ClearChat()
    print("Settings")
    print("1 : Reset Your Data")
    print("2 : Play ")
    answer = read()
    if (answer == "1") then
        shell.run("delete ToasterGoSave")
        os.reboot()
    end
end
term.setTextColor(colors.white)

--starts loading
ClearChat()
term.setTextColor(colors.red)
print("now loading")
term.setTextColor(colors.white)
settings.load("ToasterGoSave")
LastOnline = settings.get("LastOnline")
settings.save("ToasterGoSave")
print(LastOnline)

if LastOnline == nil then
    NewSave()
end
LoadSaveFile()

if LastOnline == TodaysDate then
    NewToastSpots()
    LastOnline = TodaysDate
    SaveSaveFile()
end
--ends loading




-- main game loop
while true do

TempPlayerX,TempPlayerY,TempPlayerZ = gps.locate()
--I set values again because Im planing to in the fture fix it spamming nan
if not (TempPlayerZ == nil) then
    if (TempPlayerZ < 9999999999999) then
        PlayerX = TempPlayerX
        PlayerZ = TempPlayerZ
        PlayerY = TempPlayerY
    end
end

TempDistanceToNearistToast = CheekForToast() 
if not (TempDistanceToNearistToast == 99999999) then
    DistanceToNearistToast = TempDistanceToNearistToast
    DistanceToNearistToast = math.floor(DistanceToNearistToast)

end

if (xp > ((level * level) + 15)) then
    xp = xp - ((level * level) + 15)
    level = level + 1

end
PercentToNextLevel = (xp / ((level * level)) * 100)
PercentToNextLevel = math.floor(PercentToNextLevel)
PercentToNextLevel = (" (" .. PercentToNextLevel .. "%)")

--if (PlayerY < 85) then
CheekForToastFight()

DrawMainMenu()
--else
--    ClearChat()
--    term.setTextColor(colors.red)
--    print("Please don't fly while playing this")
--end
os.sleep(0.03)
end