local ws = http.websocket("ws://localhost:8080/")

local monitor = peripheral.find("monitor")

term.redirect(monitor)
monitor.setTextScale(0.5)
--TODO:
--add pause
--add skip back and forward
--add buffer for sound
--make every websocket request async
--fix frame stutter on sound catch up

--client and server side settings
local ImageWidth = 164
local ImageHeight = 81
local SoundBufferSize = 1
--client side settings
local CatchUpSize = 2

local startTime = os.epoch("utc")

local dfpwm = require("cc.audio.dfpwm")
local decoder = dfpwm.make_decoder()
local speaker = peripheral.find("speaker")
local LastAudioCall = 0
local SoundDataCaught = ""


--clear all the lines on the monitor
--makes it so you can see debug colors
term.setBackgroundColor(1)
term.clear()
for i=1, 16 do
    term.setBackgroundColor(math.pow(2, i) / 2)
    term.setCursorPos(1, i)
    term.clearLine()
end

while true do

    local time = os.epoch("utc") - startTime
    time = time / 1000
    time = time * 20
    time = math.floor(time)

    ws.send("F" .. time + 1)

    Message = ws.receive(1)




    for i=0, 15 do 

        local ColorData = ""
        for j=1, 8 do
            local Reading = (i*8) + j
            ColorData = ColorData .. Message:sub(Reading, Reading)
        end
        --convert to rgb
        local RGBData = tonumber(ColorData) - 10000000
        local r = math.floor(RGBData / 65536)
        RGBData = RGBData - (r * 65536)
        local g = math.floor(RGBData / 256)
        RGBData = RGBData - (g * 256)
        local b = RGBData





        local Hex = colors.packRGB(r / 255, g / 255, b / 255) 


        term.setPaletteColour(math.pow(2,i) / 1, Hex)
    end

    --loop throw image data and draw
    for y=1, ImageHeight do
        CurrentDrawing = ""
        for x=1, ImageWidth do
            CurrentDrawing = CurrentDrawing .. Message:sub(((y-1)*ImageWidth) + (x-1) + 129,((y-1)*ImageWidth) + (x-1) + 129)
        end
        term.setCursorPos(1,y)
        term.blit(CurrentDrawing,CurrentDrawing,CurrentDrawing)


    end

    

    if os.epoch("utc") - LastAudioCall > (1000 * SoundBufferSize * CatchUpSize) then
        if SoundDataCaught ~= "" then
            local buffer = decoder(SoundDataCaught)
            Worked = speaker.playAudio(buffer)
            if Worked == true then
                LastAudioCall = os.epoch("utc")
            end
        end

        SoundDataCaught = ""
        for i=0, (CatchUpSize - 1) do
            ws.send("S" .. time + 1 + (i*20) + (CatchUpSize * 20))
            local SoundData = ws.receive(1)
            SoundDataCaught = SoundDataCaught .. SoundData
        end


    end

    os.sleep(0)
end
    

    



ws.close()