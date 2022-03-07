-- ______                _       _   _               _                 _     _   _          
-- | ___ \              | |     | | (_)             | |               (_)   | | (_)         
-- | |_/ /_____   _____ | |_   _| |_ _  ___  _ __   | |     ___   __ _ _ ___| |_ _  ___ ___ 
-- |    // _ \ \ / / _ \| | | | | __| |/ _ \| '_ \  | |    / _ \ / _` | / __| __| |/ __/ __|
-- | |\ \ (_) \ V / (_) | | |_| | |_| | (_) | | | | | |___| (_) | (_| | \__ \ |_| | (__\__ \
-- \_| \_\___/ \_/ \___/|_|\__,_|\__|_|\___/|_| |_| \_____/\___/ \__, |_|___/\__|_|\___|___/
--	                                                              __/ |                     
--                                                               |___/                      

-- Rovolution Logistics CDN provides a importer to load RovolutionLogistics in game tools and software

-- Please place me in ServerScriptService

-- Please report issues here, feel free to browse the code and even contribute if you want to help out! (https://github.com/RovolutionTeam/RovolutionAnalytica)

-- GeraldIn2016

local warn = function(...)
	warn(": Rovolution Logistics CDN :", ...)
end

warn("Loading...")

-- Get Globals
local API_KEY = script:FindFirstChild("API_KEY")
local ProjectID = script:FindFirstChild("ProjectID")
local HttpService = game:GetService("HttpService")

-- Make block function
do 
	if API_KEY == nil or not API_KEY:IsA("StringValue") then
		warn("No API_KEY or not a string value, RovolutionLogistics CDN can not function without it, aborting...")
		return
	end
	if ProjectID == nil or not ProjectID:IsA("StringValue") then
		warn("No ProjectID or not a string value, RovolutionLogistics CDN can not function without it, aborting...")
		return
	end
	
	-- All servies are running now lets fetch module ID and test for HTTP
	local s, data = pcall(function()
		return HttpService:JSONDecode(game:GetService('HttpService'):GetAsync('https://analytics.rovolution.me/api/v1/projectInfo/'..ProjectID.value.."?bearer_key="..API_KEY.Value))
	end)
	if s == false then
		warn("Unable to connect to Rovolution, please check HTTP is turned on in game settings, aborting...")
		return
	end
	
	
	if data.error ~= nil then
		warn(data.error..", aborting...")
		return
	end

	
	-- Now fetch module from roblox, making moduleID a number as well
	local module = require(tonumber(data.moduleID))
	
	
	-- Lets now start the module, with projectID and api key
	local errors = module.default(ProjectID.value, API_KEY.Value)

	if errors == true then
		warn("Failed to load RovolutionCDN module '"..data.moduleName.."' please check project ID and api key!")
	end
	
	warn("Successfully loaded RovolutionCDN module '"..data.moduleName.."'!")
	
-- Lodaer Finished
	
	
	script:Destroy()
end