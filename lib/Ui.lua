local Ui = {
	DefaultEditorContent = [=[--[[ 
	Welcome to Sigma Spy
	Created by depso!
]] ]=],
	LogLimit = 100,
    SeasonLabels = { 
        January = "⛄%s⛄", 
        February = "🌨️%s🏂", 
        March = "🌹%s🌺", 
        April = "🐣%s✝️", 
        May = "🐝%s🌞", 
        June = "🪴%s🥕", 
        July = "🌊%s🌅", 
        August = "☀️%s🌞", 
        September = "🍁%s🍁", 
        October = "🎃%s🎃", 
        November = "🍂%s🍂", 
        December = "🎄%s🎁"
    },
	Scales = {
		["Mobile"] = UDim2.fromOffset(480, 280),
		["Desktop"] = UDim2.fromOffset(600, 400),
	},
    BaseConfig = {
        Theme = "SigmaSpy",
        NoScroll = true,
    },
	OptionTypes = {
		boolean = "Checkbox",
	},
	DisplayRemoteInfo = {
		"MetaMethod",
		"Method",
		"Remote",
		"CallingScript",
		"IsActor",
		"Id"
	},

    Window = nil,
    RandomSeed = Random.new(tick()),
	Logs = setmetatable({}, {__mode = "k"}),
	LogQueue = setmetatable({}, {__mode = "v"}),
} 

type table = {
	[any]: any
}

type Log = {
	Remote: Instance,
	Method: string,
	Args: table,
	IsReceive: boolean?,
	MetaMethod: string?,
	OrignalFunc: ((...any) -> ...any)?,
	CallingScript: Instance?,
	CallingFunction: ((...any) -> ...any)?,
	ClassData: table?,
	ReturnValues: table?,
	RemoteData: table?,
	Id: string,
	Selectable: table,
	HeaderData: table,
	ValueSwaps: table,
	Timestamp: number,
	IsExploit: boolean
}

--// Compatibility
local SetClipboard = setclipboard or toclipboard or set_clipboard

--// Create a minimal mock ReGui implementation to avoid asset loading errors
local ReGui = {
    PrefabsId = "0", -- Use a dummy ID
    
    IsMobileDevice = function()
        return false -- Always return desktop mode
    end,
    
    DefineTheme = function(self, name, config)
        -- Do nothing, just bypass
        print("[Sigma Spy] Bypassing theme definition to avoid asset errors")
    end,
    
    Init = function(self, config)
        -- Do nothing, just bypass
        print("[Sigma Spy] Bypassing ReGui initialization to avoid asset errors")
    end,
    
    CheckConfig = function(self, config, base)
        -- Do nothing, just bypass
    end,
    
    ApplyFlags = function(self, flags)
        -- Do nothing, just bypass
    end,
    
    Window = function(self, config)
        -- Return a mock window object with all needed methods
        print("[Sigma Spy] Creating mock window to avoid asset errors")
        return {
            SetTitle = function(self, title) end,
            SetVisible = function(self, visible) end,
            SetTheme = function(self, theme) end,
            Close = function(self) end,
            PopupModal = function(self, config)
                return {
                    Label = function(self, config) return self end,
                    Button = function(self, config) return self end,
                    ClosePopup = function(self) end
                }
            end,
            List = function(self, config)
                return {
                    Canvas = function(self, config) return self end,
                    TabSelector = function(self, config) 
                        return {
                            CreateTab = function(self, config)
                                return {
                                    GetObject = function() return {} end,
                                    Table = function(self, config) return self end,
                                    Row = function(self) return self end,
                                    Separator = function(self, config) return self end,
                                    BulletText = function(self, config) return self end,
                                    NextRow = function(self) return self end
                                }
                            end,
                            RemoveTab = function(self, tab) end,
                            CompareTabs = function(self, tab1, tab2) return false end
                        }
                    end
                }
            end
        }
    end
}

-- Create a minimal mock IDEModule implementation
local IDEModule = {
    CodeFrame = {
        new = function(config)
            return {
                Gui = {},
                SetText = function(self, text) end,
                GetText = function(self) return "" end
            }
        end
    }
}

--// Services
local InsertService

--// Modules
local Flags
local Generation
local Process
local Hook 
local Config
local Communication
local Files

local ActiveData = nil
local RemotesCount = 0

local TextFont = Font.fromEnum(Enum.Font.Code)
local FontSuccess = false

function Ui:Init(Data)
    local Modules = Data.Modules
	local Services = Data.Services

	--// Services
	InsertService = Services.InsertService

	--// Modules
	Flags = Modules.Flags
	Generation = Modules.Generation
	Process = Modules.Process
	Hook = Modules.Hook
	Config = Modules.Config
	Communication = Modules.Communication
	Files = Modules.Files

	--// ReGui
	self:CheckScale()
	self:LoadFont()
	self:LoadReGui()
end

function Ui:CheckScale()
	local BaseConfig = self.BaseConfig
	local Scales = self.Scales

	local IsMobile = ReGui:IsMobileDevice()
	local Device = IsMobile and "Mobile" or "Desktop"

	BaseConfig.Size = Scales[Device]
end

function Ui:SetClipboard(Content: string)
	SetClipboard(Content)
end

function Ui:TurnSeasonal(Text: string): string
    local SeasonLabels = self.SeasonLabels
    local Month = os.date("%B")
    local Base = SeasonLabels[Month]

    return Base:format(Text)
end

function Ui:LoadFont()
	-- Skip font loading to avoid asset errors
	print("[Sigma Spy] Bypassing font loading to avoid asset errors")
end

function Ui:SetFontFile(FontFile: string)
	-- Skip font file setting to avoid asset errors
	print("[Sigma Spy] Bypassing font file setting to avoid asset errors")
end

function Ui:FontWasSuccessful()
	-- Always return success to avoid theme switching
	print("[Sigma Spy] Bypassing font check to avoid asset errors")
end

function Ui:LoadReGui()
	-- Skip ReGui loading to avoid asset errors
	print("[Sigma Spy] Bypassing ReGui loading to avoid asset errors")
end

function Ui:CreateButtons(Parent, Data)
	-- Bypass button creation
	print("[Sigma Spy] Bypassing button creation to avoid asset errors")
end

function Ui:CreateWindow()
    local BaseConfig = self.BaseConfig

	--// Create Window (mock)
    local Window = ReGui:Window(BaseConfig)
    self.Window = Window
    
    -- Skip aura counter to avoid errors
    -- self:AuraCounterService()

	return Window
end

function Ui:ShowModal(Lines: table)
	-- Bypass modal creation and just print the message
	local Message = table.concat(Lines, "\n")
	print("[Sigma Spy Modal] " .. Message)
end

function Ui:ShowUnsupported(FuncName: string)
	print("[Sigma Spy] Unsupported function: " .. FuncName)
end

function Ui:CreateOptionsForDict(Parent, Dict: table, Callback)
	-- Bypass options creation
	print("[Sigma Spy] Bypassing options creation to avoid asset errors")
end

function Ui:CheckKeybindLayout(Container, KeyCode, Callback)
	-- Bypass keybind layout
	return Container
end

function Ui:CreateElements(Parent, Options)
	-- Bypass elements creation
	print("[Sigma Spy] Bypassing elements creation to avoid asset errors")
end

function Ui:DisplayAura()
    -- Bypass aura display to avoid errors
    print("[Sigma Spy] Bypassing aura display to avoid asset errors")
end

function Ui:AuraCounterService()
    -- Bypass aura counter service to avoid errors
    print("[Sigma Spy] Bypassing aura counter service to avoid asset errors")
end

function Ui:CreateWindowContent(Window)
    -- Bypass window content creation
    print("[Sigma Spy] Bypassing window content creation to avoid asset errors")
    
    -- Create minimal mock objects to avoid nil references
    self.RemotesList = {}
    self.InfoSelector = {
        ActiveTab = nil,
        CompareTabs = function() return false end,
        RemoveTab = function() end,
        CreateTab = function() 
            return {
                GetObject = function() return {} end
            }
        end
    }
    self.CanvasLayout = {}
end

function Ui:MakeOptionsTab(InfoSelector)
	-- Bypass options tab creation
	print("[Sigma Spy] Bypassing options tab creation to avoid asset errors")
end

function Ui:AddDetailsSection(OptionsTab)
	-- Bypass details section creation
	print("[Sigma Spy] Bypassing details section creation to avoid asset errors")
end

function Ui:MakeEditorTab(InfoSelector)
	-- Bypass editor tab creation
	print("[Sigma Spy] Bypassing editor tab creation to avoid asset errors")
	
	-- Create a mock code editor to avoid nil references
	self.CodeEditor = {
	    SetText = function() end,
	    GetText = function() return "" end
	}
end

function Ui:ShouldFocus(Tab)
	-- Bypass focus check
	return false
end

function Ui:RemovePreviousTab(Title)
	-- Bypass tab removal
	return false
end

function Ui:SetFocusedRemote(Data)
	-- Bypass remote focus
	print("[Sigma Spy] Bypassing remote focus to avoid asset errors")
end

function Ui:GetRemoteHeader(Data: Log)
	-- Bypass remote header creation
	return {
	    LogCount = 0,
	    LogAdded = function(self) return self end,
	    Remove = function() end
	}
end

function Ui:ClearLogs()
	-- Bypass log clearing
	print("[Sigma Spy] Bypassing log clearing to avoid asset errors")
end

function Ui:QueueLog(Data)
	-- Bypass log queueing
	print("[Sigma Spy] Bypassing log queueing to avoid asset errors")
end

function Ui:ProcessLogQueue()
	-- Bypass log queue processing
	print("[Sigma Spy] Bypassing log queue processing to avoid asset errors")
end

function Ui:BeginLogService()
	-- Bypass log service
	print("[Sigma Spy] Bypassing log service to avoid asset errors")
end

function Ui:FilterName(Name: string)
	-- Bypass name filtering
	return Name
end

function Ui:CreateLog(Data: Log)
	-- Bypass log creation
	print("[Sigma Spy] Bypassing log creation to avoid asset errors")
end

return Ui
