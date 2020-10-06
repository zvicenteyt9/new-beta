-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vCLIENT = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local discordDPLAa = "SEUWEBHOOK"
local discordDPLAa2 = "SEUWEBHOOK"
local discordDPLAc = "SEUWEBHOOK"
local discordDPLAc2 = "SEUWEBHOOK"
local discordBallas = "SEUWEBHOOK"
local discordVagos = "SEUWEBHOOK"
local discordFamilies = "SEUWEBHOOK"
local discordMafia = "SEUWEBHOOK"
local discordMotoclub = "SEUWEBHOOK"
local discordBratva = "SEUWEBHOOK"
local discordCosanostra = "SEUWEBHOOK"
local discordCorleone = "SEUWEBHOOK"
local discordYakuza = "SEUWEBHOOK"
local discordVanilla = "SEUWEBHOOK"
local discordBahamas = "SEUWEBHOOK"
local discordDriftKing = "SEUWEBHOOK"
local discordMidnightClub = "SEUWEBHOOK"
local discordDolls = "SEUWEBHOOK"
local discordHellsAngels = "SEUWEBHOOK"
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	["Policia1"] = { 15000, ['permissao'] = "bcso.permissao" },
	["Policia2"] = { 30000, ['permissao'] = "bcso.permissao" },
	["Paramedico"] = { 5000, ['permissao'] = "dmla.permissao" },
	["Paramedico2"] = { 5000, ['permissao'] = "dmla.permissao" },
	["Ballas"] = { 5000, ['permissao'] = "ballas.permissao" },
	["Vagos"] = { 5000, ['permissao'] = "vagos.permissao" },
	["Families"] = { 5000, ['permissao'] = "families.permissao" },
	["DriftKing"] = { 5000, ['permissao'] = "driftking.permissao" },
	["Yakuza"] = { 5000, ['permissao'] = "yakuza.permissao" },
	["Corleone"] = { 5000, ['permissao'] = "corleone.permissao" },
	["Mafia"] = { 5000, ['permissao'] = "mafia.permissao" },
	["Cosanostra"] = { 5000, ['permissao'] = "cosanostra.permissao" },
	["Bratva"] = { 5000, ['permissao'] = "bratva.permissao" },
	["Motoclub"] = { 5000, ['permissao'] = "mc.permissao" },
	["MidnightClub"] = { 5000, ['permissao'] = "midnightclub.permissao" },
	["HellsAngels"] = { 5000, ['permissao'] = "hellsangels.permissao" },
	["Bahamas"] = { 5000, ['permissao'] = "bahamas.permissao" },
	["Dolls"] = { 5000, ['permissao'] = "dolls.permissao" },
	["Dolls2"] = { 5000, ['permissao'] = "dolls.permissao" },
	["Mecanico"] = { 5000, ['permissao'] = "mecanico.permissao" },
	--["Concessionaria"] = { 5000, ['permissao'] = "concessionaria.permissao" },
	--["Concessionaria2"] = { 5000, ['permissao'] = "concessionaria.permissao" },
	--["Trafico"] = { 5000, ['permissao'] = "trafico.permissao" },
	--["Families2"] = { 5000, ['permissao'] = "families.permissao" },
	--["Skulls"] = { 5000, ['permissao'] = "skulls.permissao" },
	--["Cassino"] = { 5000, ['permissao'] = "cassino.permissao" },
	--["Furious"] = { 5000, ['permissao'] = "furious.permissao" },
	--["Bennys"] = { 5000, ['permissao'] = "bennys.permissao" },
	--["Sheriff"] = { 5000, ['permissao'] = "bcso.permissao" },
	--["Mecanico"] = { 5000, ['permissao'] = "mecanico.permissao" },
	--["Mercenarios"] = { 5000, ['permissao'] = "mercenarios.permissao" },
	--["Paramedico"] = { 5000, ['permissao'] = "paramedico.permissao" },
	--["Policiasandy"] = { 5000, ['permissao'] = "bcso.permissao" },
	--["Merry"] = { 5000, ['permissao'] = "merry.permissao" },
	--["HellsAngels2"] = { 5000, ['permissao'] = "hellsangels.permissao" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			--if vRP.hasPermission(user_id,chest[chestName]['permissao']) or vRP.hasPermission(user_id,chest[chestName]['permissao2']) then
			if vRP.hasPermission(user_id,chest[chestName]['permissao']) then
				return true

			else
				TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso!",8000)
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1])
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end

			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(chest[tostring(chestName)][1]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then

							if chestName == "Policia1" then
								PerformHttpRequest(discordDPLAa, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE ARSENAL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Arsenal:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Policia2" then
								PerformHttpRequest(discordDPLAa2, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE EVIDÊNCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Evidências:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Paramedico" then
								PerformHttpRequest(discordDPLAc, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Paramedico2" then
								PerformHttpRequest(discordDPLAc2, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Ballas" then
							    PerformHttpRequest(discordBallas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })	
							elseif chestName == "Vagos" then
								PerformHttpRequest(discordVagos, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Families" then
							    PerformHttpRequest(discordFamilies, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Mafia" then
								PerformHttpRequest(discordMafia, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Motoclub" then
								PerformHttpRequest(discordMotoclub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Bratva" then
								PerformHttpRequest(discordBratva, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Cosanostra" then
								PerformHttpRequest(discordCosanostra, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Corleone" then
								PerformHttpRequest(discordCorleone, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Yakuza" then
								PerformHttpRequest(discordYakuza, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Vanilla" then
								PerformHttpRequest(discordVanilla, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Bahamas" then
								PerformHttpRequest(discordBahamas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "DriftKing" then
								PerformHttpRequest(discordDriftKing, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
							elseif chestName == "MidnightClub" then
								PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
							elseif chestName == "Dolls" then
								PerformHttpRequest(discordDolls, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Dolls2" then
								PerformHttpRequest(discordDolls, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "HellsAngels" then
								PerformHttpRequest(discordHellsAngels, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							--elseif chestName == "MidnightClub" then
							--    PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							--elseif chestName == "MidnightClub" then
							--    PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							--elseif chestName == "MidnightClub" then
							--	PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							--elseif chestName == "MidnightClub" then
						    --   	PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							--elseif chestName == "MidnightClub" then
							--	PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							--elseif chestName == "MidnightClub" then
							--	PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							--elseif chestName == "MidnightClub" then
							--	PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							--elseif chestName == "MidnightClub" then
							--	PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })

								end

							if items[itemName] ~= nil then
								items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Baú</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(chest[tostring(chestName)][1]) then
								if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then

									if items[itemName] ~= nil then
										items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end

									if chestName == "Policia1" then
										PerformHttpRequest(discordDPLAa, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE ARSENAL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Arsenal:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Policia2" then
										PerformHttpRequest(discordDPLAa2, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE EVIDÊNCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Evidências:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Paramedico" then
										PerformHttpRequest(discordDPLAc, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Paramedico2" then
										PerformHttpRequest(discordDPLAc2, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Ballas" then
										PerformHttpRequest(discordBallas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })	
									elseif chestName == "Vagos" then
										PerformHttpRequest(discordVagos, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Families" then
										PerformHttpRequest(discordFamilies, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Mafia" then
										PerformHttpRequest(discordMafia, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Motoclub" then
										PerformHttpRequest(discordMotoclub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Bratva" then
										PerformHttpRequest(discordBratva, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Cosanostra" then
										PerformHttpRequest(discordCosanostra, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Corleone" then
										PerformHttpRequest(discordCorleone, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Yakuza" then
										PerformHttpRequest(discordYakuza, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Vanilla" then
										PerformHttpRequest(discordVanilla, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Bahamas" then
										PerformHttpRequest(discordBahamas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "DriftKing" then
										PerformHttpRequest(discordDriftKing, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
									elseif chestName == "MidnightClub" then
										PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
									elseif chestName == "Dolls" then
										PerformHttpRequest(discordDolls, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "Dolls2" then
										PerformHttpRequest(discordDolls, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
									elseif chestName == "HellsAngels" then
										PerformHttpRequest(discordHellsAngels, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Adicionou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
										
										end

									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "Policia1" then
								PerformHttpRequest(discordDPLAa, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE ARSENAL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Arsenal:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Policia2" then
								PerformHttpRequest(discordDPLAa2, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE EVIDÊNCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Evidências:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Paramedico" then
								PerformHttpRequest(discordDPLAc, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Paramedico2" then
								PerformHttpRequest(discordDPLAc2, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Ballas" then
							    PerformHttpRequest(discordBallas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })	
							elseif chestName == "Vagos" then
								PerformHttpRequest(discordVagos, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Families" then
							    PerformHttpRequest(discordFamilies, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Mafia" then
								PerformHttpRequest(discordMafia, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Motoclub" then
								PerformHttpRequest(discordMotoclub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Bratva" then
								PerformHttpRequest(discordBratva, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Cosanostra" then
								PerformHttpRequest(discordCosanostra, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Corleone" then
								PerformHttpRequest(discordCorleone, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Yakuza" then
								PerformHttpRequest(discordYakuza, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Vanilla" then
								PerformHttpRequest(discordVanilla, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Bahamas" then
								PerformHttpRequest(discordBahamas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "DriftKing" then
								PerformHttpRequest(discordDriftKing, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
							elseif chestName == "MidnightClub" then
								PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
							elseif chestName == "Dolls" then
								PerformHttpRequest(discordDolls, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Dolls2" then
								PerformHttpRequest(discordDolls, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "HellsAngels" then
								PerformHttpRequest(discordHellsAngels, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
								
								end

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)

							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "Policia1" then
								PerformHttpRequest(discordDPLAa, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE ARSENAL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Arsenal:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Policia2" then
								PerformHttpRequest(discordDPLAa2, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE EVIDÊNCIAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Evidências:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Paramedico" then
								PerformHttpRequest(discordDPLAc, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Paramedico2" then
								PerformHttpRequest(discordDPLAc2, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE SUPRIMENTOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Ballas" then
							    PerformHttpRequest(discordBallas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })	
							elseif chestName == "Vagos" then
								PerformHttpRequest(discordVagos, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Families" then
							    PerformHttpRequest(discordFamilies, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Mafia" then
								PerformHttpRequest(discordMafia, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Motoclub" then
								PerformHttpRequest(discordMotoclub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Bratva" then
								PerformHttpRequest(discordBratva, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Cosanostra" then
								PerformHttpRequest(discordCosanostra, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Corleone" then
								PerformHttpRequest(discordCorleone, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Yakuza" then
								PerformHttpRequest(discordYakuza, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Vanilla" then
								PerformHttpRequest(discordVanilla, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Bahamas" then
								PerformHttpRequest(discordBahamas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "DriftKing" then
								PerformHttpRequest(discordDriftKing, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
							elseif chestName == "MidnightClub" then
								PerformHttpRequest(discordMidnightClub, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })		
							elseif chestName == "Dolls" then
								PerformHttpRequest(discordDolls, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "Dolls2" then
								PerformHttpRequest(discordDolls, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
							elseif chestName == "HellsAngels" then
								PerformHttpRequest(discordHellsAngels, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀", thumbnail = {url = "https://i.imgur.com/IP2d2mU.png"}, fields = {{ name = "**Identificação do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `" },{ name = "Tirou ao Armário de Suprimentos:", value = "` [ Item: "..vRP.itemNameList(itemName).." ][ Quantidade: "..vRP.format(parseInt(amount)).." ]` \n " }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/IP2d2mU.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
								
								end

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
			end
		end
	end
	return false
end