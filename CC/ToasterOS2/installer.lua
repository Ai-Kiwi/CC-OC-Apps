local screenXsize , screenYsize = term.getSize()
local middleXscreen = math.floor(screenXsize / 2)
local middleYscreen = math.floor(screenYsize / 2)
local logoImage = paintutils.loadImage("systemFiles/images/Logo")


function DrawDebugText(text)
    term.clear()
    offset = math.floor(string.len(text) / 2)
    paintutils.drawImage(logoImage, middleXscreen - 5, middleYscreen - 3)
    term.setCursorPos(middleXscreen - offset, middleYscreen + 5)
    term.setTextColor(colors.green)
    term.setBackgroundColor(colors.black)
    print(text)
end


function InstallProgeam(locastion,GithubURL,Name,DoApiLoad,ISGitHubUrl)
    
    if ISGitHubUrl then
        DrawDebugText("installing " .. Name .. " from github")
        local GithubFileLink = http.get(GithubURL)
        if GithubFileLink then
            github_file = GithubFileLink.readAll()
            GithubFileLink.close()
        else
            term.setTextColor(colors.red)
            DrawDebugText("error failed to dowload")
            os.sleep(3)
            error()
        end
        if github_file then
            term.setTextColor(colors.green)
            DrawDebugText("dowloading now instlling")
            fs.delete(Name)
            local f = io.open(Name, "w")
            f:write(github_file)
            f:close()
        end
    else
        shell.run("pastebin get " .. GithubURL .. " " .. Name)
    end

    if not (locastion == "") then
        locastionExists = fs.isDir(locastion)
        if not locastionExists then
            fs.makeDir(locastion)
        end
        fs.delete(locastion .. "/" .. Name)
        fs.move(Name,locastion .. "/" .. Name)
    end
    if DoApiLoad then
        fs.delete(Name)
        os.loadAPI(locastion .. "/" .. Name)
    end
end






debugText = "updating installer"
InstallProgeam("systemFiles/images","https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS2/main/images/Logo.nfp","logo.nfp",false,true)
InstallProgeam("","https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS2/main/installer.lua","startup",false,true)
InstallProgeam("systemFiles","https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS2/main/coreOS.lua","CoreOS",false,true)
InstallProgeam("systemFiles/programs","https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS2/main/progeams/FileExplorer.lua","FileExplorer",false,true)
shell.run("systemFiles/CoreOS")


-- add copyright
-- add watermark
-- add name