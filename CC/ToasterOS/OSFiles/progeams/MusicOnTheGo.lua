discs = {"record.11","record.13","record.blocks","record.cat","record.chirp","record.far","record.mall","record.mellohi","record.stal","record.strad","record.wait","record.ward"}
function ClearChat()
    term.clear()
    term.setCursorPos(1,1)
end

--play sound script
function playSound(SoundUrl)
    if speaker == nil then
        data = {}
        data[1] = "play sound request"
        data[2] = SoundUrl
        data = textutils.serialize(data)
        NeuralInterfaceID = tonumber(NeuralInterfaceID)
        rednet.send(NeuralInterfaceID,data)
    else
        speaker.playSound(SoundUrl)
    end
end



--laod settings
settings.load("systemFiles/systemSettings")
NeuralInterfaceID = settings.get("NeuralInterfaceID")
settings.save("systemFiles/systemSettings")
if not NeuralInterfaceID then NeuralInterfaceID = 0 end
NeuralInterfaceID = tonumber(NeuralInterfaceID)


local speaker = peripheral.find("speaker")


while true do
    ClearChat()
    term.setTextColor(colors.green)
    print("what sound do you wanna play?")
    print("type exit to leave or disc to play disc")
    SoundToPlay = read()
    if SoundToPlay == "exit" then
        os.reboot()
    end
    if SoundToPlay == "disc" then
        print("disc number?")
        discNumber = read()
        SoundToPlay = discs[discNumber]
    end
    HasMinecraftInIt = string.find(SoundToPlay, "minecraft:")
    if not HasMinecraftInIt then
        SoundToPlay = "minecraft:" .. SoundToPlay
    end
    playSound(SoundToPlay)
end