-----------------------------------------------------------------------------------------------------------------------------------------
-- Shark Farm
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Shark = {}
Tunnel.bindInterface("shark_cds",Shark)
vSERVER = Tunnel.getInterface("shark_cds")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONMAKERACE
-----------------------------------------------------------------------------------------------------------------------------------------
local FarmcTable = {}
local BlipscTable = {}
local CheckPoint = 0
local CreateRoute = false

if Cfg.HelpTakeCoords["HelpTakeCoord"] then
	RegisterCommand(Cfg.HelpTakeCoords["TakeCoordCommand"],function(source,args)
		local ped = PlayerPedId()
		if args[1] then
			if CreateRoute then
				CreateRoute = false
				TriggerEvent("Notify","amarelo",Cfg.HelpTakeCoords["Notifys"]["StopTakeCoords"],5000)
				SetUserRadioControlEnabled(true)
			else
				CreateRoute = true
				TriggerEvent("Notify","verde",Cfg.HelpTakeCoords["Notifys"]["StartTakeCoords"],5000)
			end
			while CreateRoute do
				local coords = GetEntityCoords(ped)
				DrawTxt("~b~E~w~  Nova Coordenada",4,0.015,0.92,0.35,255,255,255,180)
				DrawTxt("~b~H~w~  Finalizar Rota",4,0.015,0.94,0.35,255,255,255,180)
				DrawTxt("~b~X~w~  Resetar Rota",4,0.015,0.96,0.35,255,255,255,180)
				if IsControlJustPressed(1,38) then
					CheckPoint = CheckPoint + 1
					TriggerEvent("Notify","verde","Coordenada "..CheckPoint.." inserida",5000)
					table.insert(FarmcTable, { Coords = coords })
					CleanFarmcBlips()
					MakeFarmcBlips()
				end
				if IsControlJustPressed(1,74) then
					vSERVER.CreateNewRoute(FarmcTable,args[1])
					CleanFarmcBlips()
					FarmcTable = {}
					CheckPoint = 0
					TriggerEvent("Notify","verde",Cfg.HelpTakeCoords["Notify"]["StopTakeCoords"],5000)
					CreateRoute = false
				end
				if IsControlJustPressed(1,73) then
					FarmcTable = {}
					CleanFarmcBlips()
					CheckPoint = 0
					TriggerEvent("Notify","verde",Cfg.HelpTakeCoords["Notify"]["ResetTakeCoords"],5000)
				end

				for k,v in pairs(FarmcTable) do
					DrawMarker(2,FarmcTable[k]["Coords"][1],FarmcTable[k]["Coords"][2],FarmcTable[k]["Coords"][3] - 0.50,0,0,0,0,0,0,0.5,0.5,0.5,23, 145, 255,155,1,1,1,1)
				end
				Wait(3)
			end
		else
			TriggerEvent("Notify","vermelho","Insira um nome para a Rota.",5000)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanBlips()
	for Number,Bliped in pairs(Blips) do
		if DoesBlipExist(Bliped) then
			RemoveBlip(Bliped)
			Blips[Number] = nil
		end
	end

	Blips = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanFarmcBlips()
	for Number,Bliped in pairs(BlipscTable) do
		if DoesBlipExist(Bliped) then
			RemoveBlip(Bliped)
			BlipscTable[Number] = nil
		end
	end

	BlipscTable = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MakeFarmcBlips
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeFarmcBlips()
	for k,v in pairs(FarmcTable) do
		BlipscTable[k] = AddBlipForCoord(FarmcTable[k]["Coords"][1],FarmcTable[k]["Coords"][2],FarmcTable[k]["Coords"][3])
		SetBlipSprite(BlipscTable[k],1)
		SetBlipColour(BlipscTable[k],3)
		SetBlipScale(BlipscTable[k],0.85)
		ShowNumberOnBlip(BlipscTable[k],k)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)
		local width = string.len(text) / 190 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end

function DrawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKER
-----------------------------------------------------------------------------------------------------------------------------------------
function Marker(x,y,z,Item)
	if DoesBlipExist(Blips) then
		RemoveBlip(Blips)
		Blips = nil
	end

	Blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(Blips,501)
	SetBlipColour(Blips,3)
	SetBlipScale(Blips,0.5)
	SetBlipRoute(Blips,true)
	SetBlipAsShortRange(Blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar "..Item)
	EndTextCommandSetBlipName(Blips)
end