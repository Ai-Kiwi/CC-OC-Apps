local ____exports = {}
local krist = false
local ____exports = shell and ({}) or (_ENV or getfenv())
____exports.versionName = "Bigfont by Wojbie. Typescript port by Cheatoid"
____exports.versionNum = 5.003
local rawFont = {{
    "                    ",
    "               ",
    "                             ",
    "                 ",
    "       ",
    "                             ",
    "                     ",
    "                  ",
    "                                ",
    "        ",
    "             ",
    "                       ",
    "     ",
    "                 ",
    "              ",
    "          ",
    "                      ",
    "                    ",
    "                 ",
    "                ",
    "                ",
    "            ",
    "               ",
    "                     ",
    "                                        ",
    "                                        ",
    "                                                ",
    "                                        ",
    "                                        ",
    "                                ",
    "                 ",
    "                  ",
    "                           ",
    "                     ",
    "               ",
    "                             ",
    "        ",
    "             ",
    "            ",
    "    ",
    "             ",
    "                   ",
    "           ",
    "        ",
    "          ",
    "          ",
    "            ",
    "            "
}, {
    "000110000110110000110010101000000010000000100101",
    "000000110110000000000010101000000010000000100101",
    "000000000000000000000000000000000000000000000000",
    "100010110100000010000110110000010100000100000110",
    "000000110000000010110110000110000000000000110000",
    "000000000000000000000000000000000000000000000000",
    "000000110110000010000000100000100000000000000010",
    "000000000110110100010000000010000000000000000100",
    "000000000000000000000000000000000000000000000000",
    "010000000000100110000000000000000000000110010000",
    "000000000000000000000000000010000000010110000000",
    "000000000000000000000000000000000000000000000000",
    "011110110000000100100010110000000100000000000000",
    "000000000000000000000000000000000000000000000000",
    "000000000000000000000000000000000000000000000000",
    "110000110110000000000000000000010100100010000000",
    "000010000000000000110110000000000100010010000000",
    "000000000000000000000000000000000000000000000000",
    "010110010110100110110110010000000100000110110110",
    "000000000000000000000110000000000110000000000000",
    "000000000000000000000000000000000000000000000000",
    "010100010110110000000000000000110000000010000000",
    "110110000000000000110000110110100000000010000000",
    "000000000000000000000000000000000000000000000000",
    "000100011111000100011111000100011111000100011111",
    "000000000000100100100100011011011011111111111111",
    "000000000000000000000000000000000000000000000000",
    "000100011111000100011111000100011111000100011111",
    "000000000000100100100100011011011011111111111111",
    "100100100100100100100100100100100100100100100100",
    "000000110100110110000010000011110000000000011000",
    "000000000100000000000010000011000110000000001000",
    "000000000000000000000000000000000000000000000000",
    "010000100100000000000000000100000000010010110000",
    "000000000000000000000000000000110110110110110000",
    "000000000000000000000000000000000000000000000000",
    "110110110110110110000000110110110110110110110110",
    "000000000000000000000110000000000000000000000000",
    "000000000000000000000000000000000000000000000000",
    "000000000000110110000110010000000000000000010010",
    "000010000000000000000000000000000000000000000000",
    "000000000000000000000000000000000000000000000000",
    "110110110110110110110000110110110110000000000000",
    "000000000000000000000110000000000000000000000000",
    "000000000000000000000000000000000000000000000000",
    "110110110110110110110000110000000000000000010000",
    "000000000000000000000000100000000000000110000110",
    "000000000000000000000000000000000000000000000000"
}}
if krist then
    rawFont[1][31] = "                 "
    rawFont[1][32] = "                 "
    rawFont[1][33] = "                           "
    rawFont[2][32] = "000000000100110000000010000011000110000000001000"
end
local fonts = {}
local firstFont = {}
do
    local char = 0
    local height, length = #rawFont[1], #rawFont[1][1]
    for i = 1, height, 3 do
        for j = 1, length, 3 do
            local thisChar = string.char(char)
            firstFont[thisChar] = {
                {
                    string.sub(rawFont[1][i], j, j + 2),
                    string.sub(rawFont[1][i + 1], j, j + 2),
                    string.sub(rawFont[1][i + 1 + 1], j, j + 2)
                },
                {
                    string.sub(rawFont[2][i], j, j + 2),
                    string.sub(rawFont[2][i + 1], j, j + 2),
                    string.sub(rawFont[2][i + 1 + 1], j, j + 2)
                }
            }
            char = char + 1
        end
    end
    fonts[1] = firstFont
end
local inverter = {["0"] = "1", ["1"] = "0"}
local function generateFontSize(size, yeld)
    if size <= #fonts then
        return true
    end
    for f = #fonts + 1, size do
        local nextFont, lastFont = {}, fonts[f - 2 + 1]
        for char = 0, 255 do
            local thisChar = string.char(char)
            local temp, temp2 = {}, {}
            local templateChar = lastFont[thisChar][1]
            local templateBack = lastFont[thisChar][2]
            for i = 1, #templateChar do
                local line1, line2, line3, back1, back2, back3 = {}, {}, {}, {}, {}, {}
                for j = 1, #templateChar[1] do
                    local currentChar = firstFont[string.sub(templateChar[i], j, j)][1]
                    table.insert(line1, currentChar[1])
                    table.insert(line2, currentChar[2])
                    table.insert(line3, currentChar[3])
                    local currentBack = firstFont[string.sub(templateChar[i], j, j)][2]
                    if string.sub(templateBack[i], j, j) == "1" then
                        local inv = string.gsub(currentBack[1], "[01]", inverter)
                        table.insert(back1, inv)
                        inv = string.gsub(currentBack[2], "[01]", inverter)
                        table.insert(back2, inv)
                        inv = string.gsub(currentBack[3], "[01]", inverter)
                        table.insert(back3, inv)
                    else
                        table.insert(back1, currentBack[1])
                        table.insert(back2, currentBack[2])
                        table.insert(back3, currentBack[3])
                    end
                end
                table.insert(
                    temp,
                    table.concat(line1)
                )
                table.insert(
                    temp,
                    table.concat(line2)
                )
                table.insert(
                    temp,
                    table.concat(line3)
                )
                table.insert(
                    temp2,
                    table.concat(back1)
                )
                table.insert(
                    temp2,
                    table.concat(back2)
                )
                table.insert(
                    temp2,
                    table.concat(back3)
                )
            end
            nextFont[thisChar] = {temp, temp2}
            if yeld then
                local eventName = (("Font" .. tostring(f)) .. "Yeld") .. tostring(char)
                os.queueEvent(eventName)
                os.pullEvent(eventName)
            end
        end
        fonts[f] = nextFont
    end
    return true
end
generateFontSize(3)
local tHex = {
    [colors.white] = "0",
    [colors.orange] = "1",
    [colors.magenta] = "2",
    [colors.lightBlue] = "3",
    [colors.yellow] = "4",
    [colors.lime] = "5",
    [colors.pink] = "6",
    [colors.gray] = "7",
    [colors.lightGray] = "8",
    [colors.cyan] = "9",
    [colors.purple] = "a",
    [colors.blue] = "b",
    [colors.brown] = "c",
    [colors.green] = "d",
    [colors.red] = "e",
    [colors.black] = "f"
}
local function stamp(terminal, data, x, y)
    local oX, oY = terminal.getSize()
    local cX, cY = #data[1][1], #data[1]
    x = x or math.floor((oX - cX) / 2) + 1
    y = y or math.floor((oY - cY) / 2) + 1
    for i = 1, cY do
        if i > 1 and y + i - 1 > oY then
            term.scroll(1)
            y = y - 1
        end
        terminal.setCursorPos(x, y + i - 1)
        terminal.blit(data[1][i], data[2][i], data[3][i])
    end
end
local function press(terminal, data, x, y)
    local oX, oY = terminal.getSize()
    local cX, cY = #data[1][1], #data[1]
    x = x or math.floor((oX - cX) / 2) + 1
    y = y or math.floor((oY - cY) / 2) + 1
    for i = 1, cY do
        terminal.setCursorPos(x, y + i - 1)
        terminal.blit(data[1][i], data[2][i], data[3][i])
    end
end
local function makeText(size, text, nFC, nBC, blit)
    local cFC = type(nFC) == "string" and string.sub(nFC, 1, 1) or (tHex[nFC] or error("Wrong Front Color", 3))
    local cBC = type(nBC) == "string" and string.sub(nBC, 1, 1) or (tHex[nBC] or error("Wrong Back Color", 3))
    local font = fonts[size] or error("Wrong font size selected", 3)
    if text == "" then
        return {{""}, {""}, {""}}
    end
    local input = {}
    for ch in string.gmatch(text, ".") do
        table.insert(input, ch)
    end
    local lines = {}
    local height = #font[input[1]][1]
    for line = 1, height do
        local outLine = {}
        for i = 1, #input do
            outLine[i] = font[input[i]] and font[input[i]][1][line] or ""
        end
        lines[line] = table.concat(outLine)
    end
    local tFront = {}
    local tBack = {}
    local frontSub = {["0"] = cFC, ["1"] = cBC}
    local backSub = {["0"] = cBC, ["1"] = cFC}
    for line = 1, height do
        local front = {}
        local back = {}
        for i = 1, #input do
            local template = font[input[i]] and font[input[i]][2][line] or ""
            local ____temp_0 = {string.gsub(
                template,
                "[01]",
                blit and ({
                    ["0"] = string.sub(nFC, i, i),
                    ["1"] = string.sub(nBC, i, i)
                }) or frontSub
            )}
            front[i] = ____temp_0[1]
            local ____temp_1 = {string.gsub(
                template,
                "[01]",
                blit and ({
                    ["0"] = string.sub(nBC, i, i),
                    ["1"] = string.sub(nFC, i, i)
                }) or backSub
            )}
            back[i] = ____temp_1[1]
        end
        tFront[line] = table.concat(front)
        tBack[line] = table.concat(back)
    end
    return {lines, tFront, tBack}
end
function ____exports.bigWrite(text)
    stamp(
        term,
        makeText(
            1,
            text,
            term.getTextColor(),
            term.getBackgroundColor()
        ),
        term.getCursorPos()
    )
    local x, y = term.getCursorPos()
    term.setCursorPos(x, y - 2)
end
function ____exports.bigBlit(text, front, back)
    if #text ~= #front then
        error("Invalid length of text color string", 2)
    end
    if #text ~= #back then
        error("Invalid length of background color string", 2)
    end
    stamp(
        term,
        makeText(
            1,
            text,
            front,
            back,
            true
        ),
        term.getCursorPos()
    )
    local x, y = term.getCursorPos()
    term.setCursorPos(x, y - 2)
end
function ____exports.bigPrint(text)
    stamp(
        term,
        makeText(
            1,
            text,
            term.getTextColor(),
            term.getBackgroundColor()
        ),
        term.getCursorPos()
    )
    print()
end
function ____exports.hugeWrite(text)
    stamp(
        term,
        makeText(
            2,
            text,
            term.getTextColor(),
            term.getBackgroundColor()
        ),
        term.getCursorPos()
    )
    local x, y = term.getCursorPos()
    term.setCursorPos(x, y - 8)
end
function ____exports.hugeBlit(text, front, back)
    if #text ~= #front then
        error("Invalid length of text color string", 2)
    end
    if #text ~= #back then
        error("Invalid length of background color string", 2)
    end
    stamp(
        term,
        makeText(
            2,
            text,
            front,
            back,
            true
        ),
        term.getCursorPos()
    )
    local x, y = term.getCursorPos()
    term.setCursorPos(x, y - 8)
end
function ____exports.hugePrint(text)
    stamp(
        term,
        makeText(
            2,
            text,
            term.getTextColor(),
            term.getBackgroundColor()
        ),
        term.getCursorPos()
    )
    print()
end
function ____exports.writeOn(terminal, size, text, x, y)
    press(
        terminal,
        makeText(
            size,
            text,
            terminal.getTextColor(),
            terminal.getBackgroundColor()
        ),
        x,
        y
    )
end
function ____exports.blitOn(terminal, size, text, front, back, x, y)
    if #text ~= #front then
        error("Invalid length of text color string", 2)
    end
    if #text ~= #back then
        error("Invalid length of background color string", 2)
    end
    press(
        terminal,
        makeText(
            size,
            text,
            front,
            back,
            true
        ),
        x,
        y
    )
end
function ____exports.makeBlittleText(size, text, nFC, nBC)
    local out = makeText(size, text, nFC, nBC)
    out.height = #out[1]
    out.width = #out[1][1]
    return out
end
local function GenerateFontSize(size)
    if size > 6 then
        return false
    end
    return generateFontSize(
        math.floor(size),
        true
    )
end
____exports.generateFontSize = GenerateFontSize
return ____exports
