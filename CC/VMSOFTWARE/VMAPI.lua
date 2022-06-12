local function PathToList(Path)
    local PathUpto = ""
    local parts = {}
    for i=1, #Path do
        if Path[i] == "/" then
            table.insert(parts, PathUpto)
            PathUpto = ""
        else
            PathUpto = PathUpto .. Path[i]
        end
    end
    if PathUpto ~= "" then
        table.insert(parts, PathUpto)
        PathUpto = ""
    end
    local NewList = {}
    for k,v in pairs(parts) do
        if v == "" then

        elseif v == ".." then
            table.remove(NewList, #NewList)
        else
            table.insert(NewList, v)
        end
    end
    return NewList
end

local function ListToPath(List)
    local Path = "/"
    for k,v in pairs(List)
    do
        Path = Path .. v .. "/"
    end
    return List
end

local function PathToEnv(Path,EnvPath)
    local PathList = PathToList(Path)
    local EnvList = PathToList(EnvPath)
    local EnvString = ListToPath(EnvList)
    if PathList[1] == "rom" then
        return ListToPath(EnvList)
    else
        return EnvString .. ListToPath(PathList)
    end
end

local function FakeList(Path,EnvPath)
    local EnvString = ListToPath(PathToList(EnvPath))
    local PathString = ListToPath(PathToList(Path))
    local EnvFullPath = PathToEnv(Path,EnvPath)
    local TableOutput = fs.list(EnvFullPath)
    if PathString == "/" then
        table.insert(TableOutput,"rom")
    end
    return TableOutput
end