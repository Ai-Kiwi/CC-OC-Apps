local montior = peripheral.wrap("top")
montior.setTextScale(0.5)
local EnergyBlock = peripheral.wrap("energyDetector_0")
local EnergyGenBlock = peripheral.wrap("energyDetector_1")
local BatBlock = peripheral.wrap("thermal:energy_cell_0")

local PowerOutput = 160
local PowerUsingGraph = {1}
local PowerGenGraph = {1}
local BatGraph = {1}

local montiorX, montiorY = term.getSize()
local PowerDraw = EnergyBlock.getTransferRate()
local PowerMaking = EnergyGenBlock.getTransferRate()
local LargestPowerUse = math.max(unpack(PowerUsingGraph))
local BatAmtFilled = 0
local MaxBatSize = BatBlock.getEnergyCapacity()

term.redirect(montior)

local function DrawGraph(ItemToDraw,DrawWith,MaxtAmt)
  for i=1, montiorX do
    local hightToGoto = montiorY
    if ItemToDraw[i] ~= nil then
      hightToGoto = montiorY - math.floor((ItemToDraw[i] / MaxtAmt) * (montiorY - 3))
    end

    term.setCursorPos(montiorX - i,hightToGoto)

    if hightToGoto/2 == math.floor(hightToGoto/2) then
      term.setBackgroundColor(2048)
    else
      term.setBackgroundColor(4096)
    end

    term.write(DrawWith)
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


  LargestPowerUse = math.max(unpack(PowerUsingGraph))
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

  if BasePowerMinsLeftHours == (1/0) then
    BasePowerMinsLeftHours = " inf "
    BasePowerMinsLeftMins = " inf "
    BasePowerTimeLeft = " inf "
  end
  print("current power draw : " .. PowerDraw .. " RF - Power making : " .. PowerMaking .. " RF - BatFullPercent : " .. math.floor((BatAmtFilled / MaxBatSize) * 100) .. "% - EST time left : " .. BasePowerMinsLeftHours .. "h " .. BasePowerMinsLeftMins .. "m "  .. BasePowerTimeLeft .. "s")
  os.sleep(1)
end
