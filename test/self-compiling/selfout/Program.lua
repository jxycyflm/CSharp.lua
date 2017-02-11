-- Generated by CSharp.lua Compiler 1.0.0.0
local System = System
local CSharpLua
System.usingDeclare(function (global) 
    CSharpLua = global.CSharpLua
end)
System.namespace("CSharpLua", function (namespace) 
    namespace.class("Program", function (namespace) 
        local HelpCmdString, Main, ShowHelpInfo
        HelpCmdString = [[Usage: CSharp.lua [-s srcfolder] [-d dstfolder]
Arguments 
-s              : source directory, all *.cs files whill be compiled
-d              : destination  directory, will put the out lua files

Options
-h              : show the help message    
-l              : libraries referenced, use ';' to separate      
-m              : meta files, like System.xml, use ';' to separate     
-def            : defines name as a conditional symbol, use ';' to separate

-c              : support classic lua version(5.1), default support 5.3 
-i              : indent number, default is 4
-sem            : append semicolon when statement over
-a              : attributes need to export, use ';' to separate, if "-a" only, all attributes whill be exported    
]]
        Main = function (args) 
            if #args > 0 then
                local default = System.try(function () 
                    local cmds = CSharpLua.Utility.GetCommondLines(args)
                    if cmds:ContainsKey("-h") then
                        ShowHelpInfo()
                        return true
                    end

                    System.Console.WriteLine(("start {0}"):Format(System.DateTime.getNow()))

                    local folder = CSharpLua.Utility.GetArgument(cmds, "-s", false)
                    local output = CSharpLua.Utility.GetArgument(cmds, "-d", false)
                    local lib = CSharpLua.Utility.GetArgument(cmds, "-l", true)
                    local meta = CSharpLua.Utility.GetArgument(cmds, "-m", true)
                    local defines = CSharpLua.Utility.GetArgument(cmds, "-def", true)
                    local isClassic = cmds:ContainsKey("-c")
                    local indent = CSharpLua.Utility.GetArgument(cmds, "-i", true)
                    local hasSemicolon = cmds:ContainsKey("-sem")
                    local atts = CSharpLua.Utility.GetArgument(cmds, "-a", true)
                    if atts == nil and cmds:ContainsKey("-a") then
                        atts = ""
                    end
                    local w = CSharpLua.Worker:new(1, folder, output, lib, meta, defines, isClassic, indent, hasSemicolon, atts)
                    w:Do()
                    System.Console.WriteLine("all operator success")
                    System.Console.WriteLine(("end {0}"):Format(System.DateTime.getNow()))
                end, function (default) 
                    if System.is(default, CSharpLua.CmdArgumentException) then
                        local e = default
                        System.Console.getError():WriteLine(e:getMessage())
                        ShowHelpInfo()
                        System.Environment.setExitCode(- 1)
                    elseif System.is(default, CSharpLua.CompilationErrorException) then
                        local e = default
                        System.Console.getError():WriteLine(e:getMessage())
                        System.Environment.setExitCode(- 1)
                    else
                        local e = default
                        System.Console.getError():WriteLine(e:ToString())
                        System.Environment.setExitCode(- 1)
                    end
                end)
                if default then
                    return
                end
            else
                ShowHelpInfo()
                System.Environment.setExitCode(- 1)
            end
        end
        ShowHelpInfo = function () 
            System.Console.getError():WriteLine(HelpCmdString)
        end
        return {
            Main = Main
        }
    end)
end)