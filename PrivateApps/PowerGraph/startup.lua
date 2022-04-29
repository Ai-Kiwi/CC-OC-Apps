
--todo
--display different power stages and alerts on the graph
--have log system
--auto cut power to unneeded things


--setup ar goggles
local controllerBlocks = {}
controllerBlocks[1] = peripheral.wrap("arController_0")
controllerBlocks[2] = peripheral.wrap("arController_1")
for i, controller in pairs(controllerBlocks) do
  controller.setRelativeMode(true, 1600, 900)
end


local montior = peripheral.wrap("back")
montior.setTextScale(0.5)
local EnergyBlock = peripheral.wrap("energyDetector_0")
local EnergyGenBlock = peripheral.wrap("energyDetector_1")
local BatBlock = peripheral.wrap("eliteEnergyCube_1")

local montiorX, montiorY = term.getSize()
local PowerDraw = EnergyBlock.getTransferRate()
local PowerMaking = EnergyGenBlock.getTransferRate()
local BatAmtFilled = BatBlock.getEnergy()

local PowerOutput = 160
local PowerUsingGraph = {PowerDraw}
local PowerGenGraph = {PowerMaking}
local BatGraph = {BatAmtFilled}

local LargestPowerUse = math.max(unpack(PowerUsingGraph))

local MaxBatSize = BatBlock.getMaxEnergy()
local SecondPowerStageTimer = 0
local BeenInPowerProleamsFor = 0

term.redirect(montior)

local function DrawGraph(ItemToDraw,DrawWith,MaxtAmt)
  for i=1, montiorX do
    local hightToGoto = montiorY
    if ItemToDraw[i] ~= nil then
      hightToGoto = montiorY - math.floor((ItemToDraw[i] / MaxtAmt) * (montiorY - 3))
      term.setCursorPos(montiorX - i,hightToGoto)
      term.write(DrawWith)
    end



    if hightToGoto/2 == math.floor(hightToGoto/2) then
      term.setBackgroundColor(2048)
    else
      term.setBackgroundColor(4096)
    end


  end
end



while true do



  montiorX, montiorY = term.getSize()
  PowerDraw = EnergyBlock.getTransferRate()
  PowerMaking = EnergyGenBlock.getTransferRate()
  BatAmtFilled = BatBlock.getEnergy()
  table.insert(PowerUsingGraph, 1, PowerDraw)
  PowerUsingGraph[montiorX] = nil
  table.insert(PowerGenGraph, 1, PowerMaking)
  PowerGenGraph[montiorX] = nil
  table.insert(BatGraph, 1, BatAmtFilled)
  BatGraph[montiorX] = nil

  --test if power is losing then apply redstone to top
  if (PowerMaking < PowerDraw) then
    BeenInPowerProleamsFor = BeenInPowerProleamsFor + 1
    SecondPowerStageTimer = 30
  else
    BeenInPowerProleamsFor = 0
  end

  if BeenInPowerProleamsFor > 3 then
    redstone.setOutput("top", true)
  else
    redstone.setOutput("top", false)
  end

  --looks if it should start second power stage because power is to low
  SecondPowerStageTimer = SecondPowerStageTimer - 1
  if SecondPowerStageTimer > 0 then
    redstone.setOutput("right", true)
  else
    redstone.setOutput("right", false)
  end


  LargestPowerUse = math.max(unpack(PowerUsingGraph))
  if math.max(unpack(PowerGenGraph)) > LargestPowerUse then
    LargestPowerUse = math.max(unpack(PowerGenGraph))
  end

  LargestPowerUse = math.sqrt((LargestPowerUse) + 1)
  LargestPowerUse = LargestPowerUse * LargestPowerUse



  term.clear()
  for i=1, montiorY do
    if i/2 == math.floor(i/2) then
      term.setBackgroundColor(2048)
    else
      term.setBackgroundColor(4096)
    end

    term.setCursorPos(1,i)
    term.clearLine()

  end
  DrawGraph(BatGraph,"%",MaxBatSize)
  DrawGraph(PowerGenGraph,"+",LargestPowerUse)
  DrawGraph(PowerUsingGraph,"-",LargestPowerUse)


  for i=1, (montiorY - 3) do
    term.setCursorPos(1,montiorY - i)

    if i/2 == math.floor(i/2) then
      term.setBackgroundColor(2048)
    else
      term.setBackgroundColor(4096)
    end
    term.write(math.floor((i * LargestPowerUse) / (montiorY - 3)) .. " ")


  end
  term.setBackgroundColor(2048)
  term.setCursorPos(1,montiorY)
  term.write("0 ")

  term.setCursorPos(1,1)
  local BasePowerTimeLeft = math.floor((BatAmtFilled / (PowerDraw - PowerMaking)) / 20)
  --get mins
  local BasePowerMinsLeftMins = math.floor(BasePowerTimeLeft / 60)
  BasePowerTimeLeft = BasePowerTimeLeft - (BasePowerMinsLeftMins * 60)
  local BasePowerMinsLeftHours = math.floor(BasePowerMinsLeftMins / 60)
  BasePowerMinsLeftMins = BasePowerMinsLeftMins - (BasePowerMinsLeftHours * 60)


  --print(" RF)

  local TextToWrite = ""

  TextToWrite = TextToWrite .. "current power draw : " .. PowerDraw .. " RF"
  TextToWrite = TextToWrite .. " - Power making : " .. PowerMaking .. " RF"
  if BatAmtFilled > (MaxBatSize - PowerDraw - 100) then
  else
    TextToWrite = TextToWrite .. " - BatFullPercent : " .. math.floor((BatAmtFilled / MaxBatSize) * 100) .. "%"
  end

  if BasePowerMinsLeftHours == (1/0) then
    BasePowerMinsLeftHours = " inf "
    BasePowerMinsLeftMins = " inf "
    BasePowerTimeLeft = " inf "
  else
    if BasePowerMinsLeftHours > 0 then
      TextToWrite = TextToWrite .. " - EST left : " .. BasePowerMinsLeftHours .. "h " .. BasePowerMinsLeftMins .. "m "  .. BasePowerTimeLeft .. "s"
    end
  end

  if BeenInPowerProleamsFor > 0 then
    TextToWrite = TextToWrite .. " - proleam time : " .. BeenInPowerProleamsFor
  end
  if SecondPowerStageTimer > 0 then
    TextToWrite = TextToWrite .. " - Second stage time : " .. SecondPowerStageTimer
  end

  term.write(TextToWrite)

  --do stuff for ar goggles
  for i, controller in pairs(controllerBlocks) do
    controller.clear()
    if redstone.getInput("left") then
      controller.fill(0,0,1600,900, 0x000000)
    else

          --controller.drawString(os.date(), 0, 0, 0xffffff)
      if BeenInPowerProleamsFor > 3 then
        if (BeenInPowerProleamsFor / 2) == math.floor(BeenInPowerProleamsFor / 2) then
          controller.drawString(TextToWrite, 0, 0, 0xffff00)
        else
          controller.drawString(TextToWrite, 0, 0, 0xff0000)
        end
      else
        controller.drawString(TextToWrite, 0, 0, 0xffffff)
      end
    end



  end

  while redstone.getInput("left") do
    os.sleep(1)
  end

  os.sleep(1)
end
