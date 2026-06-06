shell.run("delete startup")
shell.run("pastebin get 3AA7FNLd startup")


Fristcell = peripheral.wrap("top")
 -- Powercap = Fristcell.getMaxEnergyStored()
redstone.setOutput("top",false)

shell.run("delete AIKIWIBANKAPI") -- removes old api
shell.run("pastebin get WxsMPXqi AIKIWIBANKAPI") --download new api version
os.loadAPI("AIKIWIBANKAPI") -- loads api
rednet.open("back") -- opens port on back side
redstone.setOutput("left",false)

function OutputPower(IsTrue)
    if IsTrue then
        redstone.setOutput("top",true)
    else
        redstone.setOutput("top",false)
    end
end



function GetPowerLevel()
return Fristcell.getEnergyStored()
end

OutputPower(false)
AmtLeftInServer = 0
ServerStartedWith = GetPowerLevel()




function UserBuyingPower()
    while true do
        AmtServerPaid, UserSentMoney = AIKIWIBANKAPI.CheekForPayment()
    if AmtServerPaid then
        AmtGettingPaid = AmtServerPaid * 1000
        TempPowerLevel = GetPowerLevel()
        if TempPowerLevel > AmtLeftInServer + AmtGettingPaid then
            print(AmtGettingPaid)
            AmtLeftInServer = AmtLeftInServer + AmtGettingPaid
            redstone.setOutput("left",true)
            os.sleep(0.5)
            redstone.setOutput("left",false)
            DoCheekForGivePower = true
        else
            AIKIWIBANKAPI.PayMoney(UserSentMoney,AmtServerPaid)
            print(UserPaidToMuch)
        end
    end
    end
end





function MoreLeftInSystem()
while true do    
    if DoCheekForGivePower then

        AmtServerHas = GetPowerLevel()
        
        if ServerStartedWith - AmtLeftInServer  < AmtServerHas then
            OutputPower(true)
        else
            ServerStartedWith = GetPowerLevel()
            AmtLeftInServer = 0
            OutputPower(false)
            DoCheekForGivePower = false
        end
        redstone.setOutput("right",false)
    end
    
    os.sleep(0.1)
end
end

function UserSellingRF()
    while true do    
        if not DoCheekForGivePower then
            redstone.setOutput("right",true)
        end
        os.sleep(0.1)
    end
    
end



-- 1,000,000
-- 900,000
parallel.waitForAll(MoreLeftInSystem,UserBuyingPower,UserSellingRF)