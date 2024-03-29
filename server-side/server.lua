-----------------------------------------------------------------------------------------------------------------------------------------
-- Shark Farm
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Shark = {}
Tunnel.bindInterface("shark_cds",Shark)
vCLIENT = Tunnel.getInterface("shark_cds")
REQUEST = Tunnel.getInterface("request")
-----------------------------------------------------------------------------------------------------------------------------------------
-- Create New Route
-----------------------------------------------------------------------------------------------------------------------------------------
function Shark.CreateNewRoute(FarmcTable,RaceName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		for k,v in pairs(FarmcTable) do
			vRP.Archive(RaceName..".txt","x = "..mathLength(FarmcTable[k]["Coords"][1])..", y = "..mathLength(FarmcTable[k]["Coords"][2])..", z = "..mathLength(FarmcTable[k]["Coords"][3])..",")
		end
	end
end