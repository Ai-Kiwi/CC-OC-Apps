fs.delete("Installer")

print("installing " .. Name .. " from github")
local GithubFileLink = http.get("https://raw.githubusercontent.com/Ai-Kiwi/ToasterOS/Dev/OSFiles/ToasterOS_Updater.lua")
if GithubFileLink then
    github_file = GithubFileLink.readAll()
else
    print("error failed to dowload")
end
GithubFileLink.close()
local f = io.open(Name, "w")
f:write(github_file)
f:close()
shell.run("Installer")