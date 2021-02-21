--[[ Optimization ]]--
local tonumber, next = tonumber, next
local str_sub, str_find, str_match, str_gsub, str_gmatch, str_format, str_rep = string.sub, string.find, string.match, string.gsub, string.gmatch, string.format, string.rep
local mt_cos, mt_sin, mt_random, mt_floor, mt_ceil = math.cos, math.sin, math.random, math.floor, math.ceil
local tbl_concat, tbl_unpack = table.concat, table.unpack
local time = os.time

--[[ Module Info ]]--
local module = {
	name = "ca21",
	formalName = "Carnaval Trio",
	team = {
		developer = "Bolodefchoco#0015",
		artist = "Furianera#0506"
	},
	reward = "titre_carnaval_lua",
	time = 1.85 * 60,
	map = {
		xml = [[<C><P L="1600" H="600"/><Z><S><S T="12" X="192" Y="453" L="214" H="10" P="0,0,0.3,0.2,10,0,0,0" /><S T="12" X="337" Y="423" L="10" H="123" P="0,0,0.3,0.2,35,0,0,0" /><S T="13" X="387" Y="513" L="73" P="0,0,0.3,0.85,0,0,0,0" /><S T="12" X="661" Y="510" L="435" H="10" P="0,0,0.3,0.2,10,0,0,0" /><S T="13" X="923" Y="600" L="116" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="1093" Y="528" L="281" H="10" P="0,0,0.3,0.2,-3,0,0,0" /><S T="13" X="1273" Y="629" L="164" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="1489" Y="518" L="232" H="10" P="0,0,0.3,0.2,5,0,0,0" /><S T="13" X="1506" Y="537" L="49" P="0,0,0.3,1.5,0,0,0,0" /><S T="12" X="1457" Y="364" L="78" H="24" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="1584" Y="364" L="75" H="24" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="1461" Y="228" L="10" H="158" P="0,0,0.3,0.2,50,0,0,0" /><S T="12" X="1521" Y="281" L="246" H="10" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="1574" Y="213" L="132" H="10" P="0,0,0.3,0.2,35,0,0,0" /><S T="12" X="1220" Y="311" L="20" H="180" P="0,0,0.05,0.2,-30,0,0,0" /><S T="12" X="211" Y="273" L="20" H="144" P="0,0,0.3,0.2,30,0,0,0" /><S T="12" X="1112" Y="273" L="159" H="11" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="1074" Y="401" L="210" H="10" P="0,0,0.3,0.2,10,0,0,0" /><S T="12" X="1214" Y="407" L="80" H="10" P="0,0,0.3,0.2,-20,0,0,0" /><S T="12" X="65" Y="398" L="86" H="23" P="0,0,0.3,0.2,5,0,0,0" /><S T="12" X="56" Y="325" L="10" H="189" P="0,0,0.3,0.2,-12,0,0,0" /><S T="13" X="247" Y="364" L="20" P="0,0,0.3,1,0,0,0,0" /><S T="13" X="189" Y="153" L="14" P="0,0,0.3,0.8,0,0,0,0" /><S T="13" X="252" Y="188" L="14" P="0,0,0.3,0.5,0,0,0,0" /><S T="13" X="312" Y="163" L="14" P="0,0,0.3,0.8,0,0,0,0" /><S T="12" X="449" Y="299" L="27" H="10" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="538" Y="262" L="136" H="10" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="473" Y="279" L="10" H="39" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="1160" Y="255" L="10" H="41" P="0,0,0.3,0.2,40,0,0,0" /><S T="12" X="1605" Y="100" L="10" H="999" P="0,0,0,0.2,0,0,0,0" /><S T="12" X="20" Y="80" L="10" H="999" P="0,0,0,0.2,0,0,0,0" /><S T="12" X="608" Y="301" L="10" H="157" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="649" Y="219" L="92" H="10" P="0,0,0.3,0.2,0,0,0,0" /><S T="12" X="728" Y="249" L="93" H="10" P="0,0,0.3,0.2,40,0,0,0" /><S T="12" X="864" Y="266" L="233" H="10" P="0,0,0.3,0.2,0,0,0,0" /></S><D><DS X="923" Y="472"/></D><O/><L/></Z></C>]],
		background = "17763386955.png"
	},
	minPlayers = 5,
	maxPlayers = 60,
	pieces_to_build_trio = 55,
	decorations_to_finish_trio = 35,
	time_to_teleport_collectables = 15 * 1000,
	total_instrument_sequences = 14
}

if (not tfm.get.room.playerList[module.team.developer] and (tfm.get.room.uniquePlayers < module.minPlayers or tfm.get.room.uniquePlayers > module.maxPlayers)) then
	return system.exit()
end

math.randomseed(time())

--[[ Translations ]]--
local translation
do
	local translations = {
		en = {
			credits = "\n\n<p align='center'><font size='-1'>Event by <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font>, amazing art by <FC>Furianera</FC><font size='-3'><G>#0506</G></font>.</font></p>",
			buildTrio = "Aaaaaaah, a beautiful beach!\nBut hey, wait! You got work to do.\n\nFetch these objects around the map and bring them to the Electric Trio <font size='-2'>(truck/container)</font>. We have a party tonight.",
			decorateTrio = "OwO This Electric Trio looks so nice! It's time to decorate it!",
			playInstruments = "Everything's ready for tonight! It's party time!!!!\n\nHow about trying some typical Brazilian Carnival instruments? Go on the Electrio Trio and give them a try.",
			finished = "Yupiiiiiiiiiiiiii! It's time to cut a rug! Enjoy Carnival on the beach! <font size='-2'>(only on Transformice, right?)</font>",
			carnival = "CARNIVAL!"
		},
		br = {
			credits = "\n\n<p align='center'><font size='-1'>Evento por <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font>, arte incrível por <FC>Furianera</FC><font size='-3'><G>#0506</G></font>.</font></p>",
			buildTrio = "Aaaaaaah, uma praia linda!\nMas ei, psiu, espera aí! Você tem trabalho a fazer.\n\nPegue esses objetos no mapa e leve-os até o Trio Elétrico. Teremos uma festona hoje a noite.",
			decorateTrio = "OwO Esse Trio Elétrico está tão legal! Agora é hora de decorá-lo!",
			playInstruments = "Está tudo pronto para hoje a noite! É hora de festejar!!!!\n\nQue tal tentar tocar alguns instrumentos típicos do Carnaval? Vá no Trio Eléctrico e experimente.",
			finished = "Uhuuuuuuuuuuuuu! É hora de balançar o esqueleto! Curta o Carnaval na praia! <font size='-2'>(apenas no Transformice, hein?)</font>",
			carnival = "CARNAVAL!"
		},
		es = {
			credits = "\n\n<p align='center'><font size='-1'>Evento por <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font>, arte asombroso por <FC>Furianera</FC><font size='-3'><G>#0506</G></font>.</font></p>",
			buildTrio = "¡Aaaaaaah!, ¡Una hermosa playa!\n¡Pero oye, espera! Tienes trabajo que hacer.\n\nConsigue estos objetos por el mapa y llévelos a la Tarima Móvil. Tenemos una fiesta esta noche.",
			decorateTrio = "OwO ¡Esta Tarima Móvil se ve genial! ¡Es hora de decorarlo!",
			playInstruments = "¡Todo listo para esta noche! ¡¡¡¡Es tiempo de fiesta!!!!\n\n¿Qué tal probar algunos instrumentos típicos del Carnaval brasileño? Sube a la Tarima Móvil y pruébalos.",
			finished = "¡Yupiiiiiiiiiiiiii! ¡Es hora de cortar una alfombra! ¡Disfruta del Carnaval en la playa! <font size='-2'>(Solamente en Transformice, ¿Cierto?)</font>",
			carnival = "¡CARNAVAL!"
		},
		cn = {
			credits = "\n\n<p align='center'><font size='-1'>活動製作: <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font>, 驚世藝術繪畫: <FC>Furianera</FC><font size='-3'><G>#0506</G></font>.</font></p>",
			buildTrio = "啊, 是個好美麗的海灘!\n但是, 等等! 你有工作要做。\n\n把散落在地圖上的物品撿起帶到巡遊花車上。我們今天晚上有派對喔。",
			decorateTrio = "OwO 這輛巡遊花車真好看! 是時候把它裝飾一下!",
			playInstruments = "一切都為今天晚上預備好了! 現在是派對時間!!!!\n\n要來嘗試一下傳統的巴西狂歡節樂器嗎? 到巡遊花車上試一下吧。",
			finished = "好耶耶耶耶! 是跳搖擺舞的時間了! 在海灘上盡情享受這個狂歡節吧! <font size='-2'>(只有在 Transformice 才行, 對吧?)</font>",
			carnival = "狂歡節!"
		},
		it = {
			credits = "\n\n<p align='center'><font size='-1'>Evento creato da <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font>, incredibili disegni di <FC>Furianera</FC><font size='-3'><G>#0506</G></font>.</font></p>",
			buildTrio = "Aaaaaaah, una bellissima spiaggia!\nMa hey, aspetta! C'è del lavoro da fare.\n\nRaccogli gli oggetti in giro per la mappa e portali al Trio Elettrico. Abbiamo un festa stanotte.",
			decorateTrio = "OwO Questo Trio Elettrico sembra così carino! È tempo di decorarlo!",
			playInstruments = "È finalmente tutto pronto per stasera! È tempo di festeggiare!!!!\n\nChe ne pensi di qualche strumento musicale tipico del Carnevale Brasiliano? Sali sul Trio Elettrico e prova a suonarli.",
			finished = "Evvivaaaaaa! È tempo di festeggiare! Divertiti al Carnevale in spiaggia! <font size='-2'>(solo su Transformice però, vero?)</font>",
			carnival = "CARNEVALE!"
		},
		hu = {
			credits = "\n\n<p align='center'><font size='-1'>Az Eventet <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font> készítette, a gyönyörű rajzot pedig <FC>Furianera</FC><font size='-3'><G>#0506</G></font> készítette.</font></p>",
			buildTrio = "Aaaaaaah, milyen gyönyörű strand!\nDe hé, várjunk csak! Még van egy kis munkád.\n\nGyűjtsd össze a különböző tárgyakat a pályán és hozd vissza őket az Electric Triohoz. Buli lesz ma este.",
			decorateTrio = "OwO Ez az Electric Trio nagyon jól néz ki! Ideje feldíszíteni!",
			playInstruments = "Minden készen áll ma estére! Itt a buli ideje!!!!\n\nMit szólnál ahhoz, ha kipróbálnánk néhány tipikus brazil hangszereket? Menj fel az Electric Triora és próbáld ki őket.",
			finished = "Yupiiiiiiiiiiiiii! Ideje táncolni! Élvezd a karnevált a strandon! <font size='-2'>(de csak a Transformice-szon, ugye?)</font>",
			carnival = "KARNEVÁL!"
		},
		tr = {
			credits = "\n\n<p align='center'><font size='-1'>Etkinliği yapan: <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font>, inanılmaz resimleri yapan: <FC>Furianera</FC><font size='-3'><G>#0506</G></font>.</font></p>",
			buildTrio = "Aaaaaaah, güzel bir plaj!\nAma hey, bekle! Yapacak işin var!\n\nHaritanın etrafındaki objeleri topla ve Electric Trio'ya götür. Bu gece partimiz var.",
			decorateTrio = "OwO Bu Electric Trio çok güzel görünüyor! Dekore etme zamanı!",
			playInstruments = "Bu gece için her şey hazır! Parti zamanı!!!!\n\nTipik Brezilya Karnavalı enstrümanlarını denemeye ne dersiniz? Electrio Trio'ya gidin ve onları bir deneyin.",
			finished = "Yupiiiiiiiiiiiiii! Şimdi dans etme zamanı! Plajda Karnavalın tadını çıkarın! <font size='-2'>(sadece Transformice'de, değil mi?)</font>",
			carnival = "KARNAVAL!"
		},
		fr = {
			credits = "\n\n<p align='center'><font size='-1'>Event par <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font>, incroyable art par <FC>Furianera</FC><font size='-3'><G>#0506</G></font>.</font></p>",
			buildTrio = "Woaaaah, une super plage !\nMais... attend ! T'as du travail à faire.\n\nRécupère ces objets sur toute la carte et rapporte-les au Trio Électrique <font size='-2'>(char du Carnaval)</font>. Nous avons une fête prévue ce soir.",
			decorateTrio = "OwO Ce Trio Électrique a l'air très bien ! C'est l'heure de le décorer !",
			playInstruments = "Tout est prêt pour cette nuit ! Place à la fête !!!!\n\nPourquoi ne pas essayer quelques instruments de musique brésiliens ? Va sur le Trio Electrique et tente ta chance.",
			finished = "Youpiiiiiiiiiiiiii! C'est l'heure de danser ! Profite du Carnaval sur la plage !<font size='-2'>(sur Transformice seulement, ok?)</font>",
			carnival = "CARNAVAL!"
		},
		bg = {
			credits = "\n\n<p align='center'><font size='-1'>Event by <FC>Bolodefchoco</FC><font size='-3'><G>#0015</G></font>, amazing art by <FC>Furianera</FC><font size='-3'><G>#0506</G></font>.</font></p>",
			buildTrio = "Ахххххх, какъв хубав плаж!!\nНо хей, почакай! Имаш работа за вършене.\n\nОлови тези предмети по картата и ги донеси до Трио Електрик <font size='-2'>(truck/container)</font>. Ще имаме купон тази вечер.",
			decorateTrio = "OwO Това Трио Електрик изглежда толкова добре! Време е за декорация!",
			playInstruments = "Всичко е готово за тази вечер! Време е за купон!!!!\n\n Какво ще кажеш да пробваме няколко типични Бразилски Карнавални инструменти? Отиди на Трио Електрик и ги изпробвай.",
			finished = "Юпииииииии! Време е за танци! Наслади се на карнавала на плажа! <font size='-2'>(само в Transformice, нали?)</font>",
			carnival = "КАРНАВАЛ!"
		},
	}
	translation = translations[tfm.get.room.community] or translations.en
end

--[[ Data ]]--
-- Laagaadoo's DataHandler
local DataHandler, playerCache = { }, { }
do
	DataHandler.__index = DataHandler

	DataHandler.new = function(moduleID, structure)
		local structureIndexes = { }
		for k, v in next, structure do
			structureIndexes[v.index] = k
			v.type = v.type or type(v.default)
		end

		return setmetatable({
			playerData = { },
			moduleID = moduleID,
			structure = structure,
			structureIndexes = structureIndexes,
			otherPlayerData = { }
		}, DataHandler)
	end

	local extractPlayerData = function(self, dataStr)
		local i, module, j = str_match(dataStr, "()" .. self.moduleID .. "=(%b{})()")
		if i then
			return module, (str_sub(dataStr, 1, i - 1) .. str_sub(dataStr, j + 1))
		end
		return nil, dataStr
	end

	local replaceComma = function(str)
		return str_gsub(str, ',', '\0')
	end

	local getDataNameById = function(structure, index)
		for k, v in next, structure do
			if v.index == index then
				return k
			end
		end
	end

	local strToTable

	strToTable = function(str)
		local out, index = { }, 0

		str = str_gsub(str, "%b{}", replaceComma)

		local tbl
		for value in str_gmatch(str, "[^,]+") do
			value = str_gsub(value, "%z", ',')

			tbl = str_match(value, "^{(.-)}$")

			index = index + 1
			if tbl then
				out[index] = strToTable(tbl)
			else
				out[index] = tonumber(value) or value
			end
		end

		return out
	end

	local getDataValue = function(value, valueType, valueName, valueDefault)
		if valueType == "boolean" then
			if value then
				value = (value == '1')
			else
				value = valueDefault
			end
		elseif valueType == "table" then
			value = str_match(value or '', "^{(.-)}$")
			value = value and strToTable(value) or valueDefault
		else
			if valueType == "number" then
				value = value and tonumber(value, 16)
			elseif valueType == "string" and value then
				value = str_match(value, "^\"(.-)\"$")
			end
			value = value or valueDefault
		end

		return value
	end

	local handleModuleData = function(self, playerName, structure, moduleData)
		local playerData = self.playerData[playerName]
		local valueName

		local dataIndex = 1
		if #moduleData > 0 then
			moduleData = str_gsub(moduleData, "%b{}", replaceComma)

			for value in str_gmatch(moduleData, "[^,]+") do
				value = str_gsub(value, "%z", ',')

				valueName = getDataNameById(structure, dataIndex)
				playerData[valueName] = getDataValue(value, structure[valueName].type, valueName,
					structure[valueName].default)
				dataIndex = dataIndex + 1
			end
		end

		local higherIndex = #self.structureIndexes
		if dataIndex <= higherIndex then
			for i = dataIndex, higherIndex do
				valueName = getDataNameById(structure, i)
				playerData[valueName] = getDataValue(nil, structure[valueName].type, valueName,
					structure[valueName].default)
			end
		end
	end

	DataHandler.newPlayer = function(self, playerName, data)
		data = data or ''

		self.playerData[playerName] = { }

		local module, otherData = extractPlayerData(self, data)
		self.otherPlayerData[playerName] = otherData

		handleModuleData(self, playerName, self.structure, (module and str_sub(module, 2, -2) or ''))

		return self
	end

	local tblToStr
	local transformType = function(valueType, index, str, value)
		if valueType == "number" then
			index = index + 1
			str[index] = str_format("%x", value)
		elseif valueType == "string" then
			index = index + 1
			str[index] = '"'
			index = index + 1
			str[index] = value
			index = index + 1
			str[index] = '"'
		elseif valueType == "boolean" then
			index = index + 1
			str[index] = (value and '1' or '0')
		elseif valueType == "table" then
			index = index + 1
			str[index] = '{'
			index = index + 1
			str[index] = tblToStr(value)
			index = index + 1
			str[index] = '}'
		end
		return index
	end

	tblToStr = function(tbl)
		local str, index = { }, 0

		local valueType
		for k, v in next, tbl do
			index = transformType(type(v), index, str, v)
			index = index + 1
			str[index] = ','
		end

		if str[index] == ',' then
			str[index] = ''
		end

		return tbl_concat(str)
	end

	local dataToStr = function(self, playerName)
		local str, index = { self.moduleID, "={" }, 2

		local playerData = self.playerData[playerName]
		local structureIndexes = self.structureIndexes
		local structure = self.structure

		local valueName, valueType, value
		for i = 1, #structureIndexes do
			valueName = structureIndexes[i]
			index = transformType(structure[valueName].type, index, str, playerData[valueName])
			index = index + 1
			str[index] = ','
		end

		if str[index] == ',' then
			str[index] = '}'
		else
			str[index + 1] = '}'
		end

		return tbl_concat(str)
	end

	DataHandler.dumpPlayer = function(self, playerName)
		local otherPlayerData = self.otherPlayerData[playerName]
		if otherPlayerData == '' then
			return dataToStr(self, playerName)
		else
			return dataToStr(self, playerName) .. "," .. otherPlayerData
		end
	end

	DataHandler.get = function(self, playerName, valueName)
		return self.playerData[playerName][valueName]
	end

	DataHandler.set = function(self, playerName, valueName, newValue, sum, _forceSave)
		playerName = self.playerData[playerName]
		if sum then
			playerName[valueName] = playerName[valueName] + newValue
		else
			playerName[valueName] = newValue
		end
		return self
	end

	DataHandler.save = function(self, playerName)
		system.savePlayerData(playerName, self:dumpPlayer(playerName))

		return self
	end
end

local playerData = DataHandler.new(module.name, {
	buildingTrio = {
		index = 1,
		default = true,
	},
	collected = {
		index = 2,
		default = 0
	},
	finishedEvent = {
		index = 3,
		default = false
	}
})

local idEnums = {
	progressBar = 0,
	callback = 100,
	hud = 200,
	background = 300
}

local images = {
	trioBuilding = {
		"17732e267d2.png",
		"17732e27f44.png",
		"17732e296b5.png",
		"17732e2ae4a.png",
	},
	trioDecorating = {
		"17732e2ae4a.png",
		"17732e2c599.png",
		"17732e2dd0a.png",
		"17732e2f47b.png",
		"17732e30bef.png",
		"17732e3235e.png",
		"17732e33ad2.png",
		"17732e35247.png"
	},
	trioPieces = {
		[-7] = "17720089983.png", -- Transparent
		[-6] = "17720088211.png", -- Transparent
		[-5] = "17720086a9f.png", -- Transparent
		[-4] = "1772008532c.png", -- Transparent
		[-3] = "17720083bbb.png", -- Transparent
		[-2] = "17720080cd8.png", -- Transparent
		[-1] = "1772007ddf4.png", -- Transparent
		[0] = "1773277397f.png", -- Thumb
		[1] = "1777e6cf37c.png", -- Solid
		[2] = "1777e6d0aec.png", -- Solid
		[3] = "1777e6d225f.png", -- Solid
		[4] = "1777e6d8025.png", -- Solid
		[5] = "1777e6d9797.png", -- Solid
		[6] = "1777e6daf0a.png", -- Solid
		[7] = "1777e6dc67a.png", -- Solid
	},
	trioDecorations = {
		[-6] = "1772008244a.png", -- Transparent
		[-5] = "1772007f566.png", -- Transparent
		[-4] = "1772007c691.png", -- Transparent
		[-3] = "1772007af10.png", -- Transparent
		[-2] = "1772007979f.png", -- Transparent
		[-1] = "1772007802d.png", -- Transparent
		[0] = "177327691d6.png", -- Thumb
		[1] = "1777e6d39cf.png", -- Solid
		[2] = "1777e6d5142.png", -- Solid
		[3] = "1777e6d68b3.png", -- Solid
		[4] = "1777e6ddded.png", -- Solid
		[5] = "1777e6df55d.png", -- Solid
		[6] = "1777e6e0cce.png", -- Solid
	},
	instruments = {
		[-8] = "17737d1612b.png", -- Transparent
		[-7] = "17737d14202.png", -- Transparent
		[-6] = "17737d0f72b.png", -- Transparent
		[-5] = "17737d0cc69.png", -- Transparent
		[-4] = "17737d0abd0.png", -- Transparent
		[-3] = "17737d063fc.png", -- Transparent
		[-2] = "17737c9f9df.png", -- Transparent
		[-1] = "17737c8fcd0.png", -- Transparent

		[1] = "17737a42290.png", -- surdo
		[2] = "17737a459f9.png", -- repique
		[3] = "17737a47169.png", -- caixa de guerra
		[4] = "17737a569ff.png", -- cuíca
		[5] = "17737a4a04b.png", -- pandeiro
		[6] = "17737a4b7bd.png", -- tamborim
		[7] = "17737a4cf2f.png", -- agogô
		[8] = "17737a4decf.png" -- chocalho
	},
	emotes = {
		carnaval = "17199fa3a38.jpg",
		jigglypuff = "17199e5d230.jpg",
		marshmallow = "17199e61885.jpg",
		partyhorn = "17199fa8269.jpg",
		selfie = "17199e7dd05.jpg"
	},
	cursor = "1777e79e4bf.png"
}

local objectSpawnPoints = {
	{ 40, 180 },
	{ 100, 350 },
	{ 250, 60 },
	{ 290, 250 },
	{ 460, 50 },
	{ 475, 220 },
	{ 670, 480 },
	{ 1085, 215 },
	{ 1150, 365 },
	{ 1160, 110 },
	{ 1410, 430 },
	{ 1475, 150 },
	{ 1550, 320 }
}

local progressBarData = {
	-- Coordinates
	[0] = nil,

	-- Progress Limit, Background Color, Progress Color
	[1] = { module.pieces_to_build_trio, 0x8F7932, 0xFFDA05 },
	[2] = { module.decorations_to_finish_trio, 0x76328F, 0xB06DD6 }
}

local consumables = {
	20, -- chicken
	24, -- fish
	26, -- paperBall
	33, -- partyBlower
}

local instrumentPositions = {
	-- x, y, w, g
	[1] = { 110, 250, 169, 148 },
	[2] = { 340, 225, 135, 175 },
	[3] = { 535, 325, 147, 71 },
	[4] = { 535, 170, 152, 118 },
	[5] = { 555, 60, 107, 66 },
	[6] = { 355, 120, 101, 70 },
	[7] = { 375, 30, 69, 62 },
	[8] = { 140, 150, 98, 69 }
}

local totalEmotes = 0
do
	for _ in next, images.emotes do
		totalEmotes = totalEmotes + 1
	end
	totalEmotes = (800 - totalEmotes*55)
end

--[[ Functions & Classes ]]--
local callback
do
	local id = idEnums.callback

	callback = {
		_instance = {
			_count = 0
		}
	}
	callback.__index = callback
	callback.__iter = function()
		return ipairs(callback._instance)
	end
	callback.__get = function(eventName)
		return callback._instance[callback._instance[eventName]]
	end

	callback.new = function(eventName, x, y, width, height, hideCallback)
		id = id + 1

		local self = setmetatable({
			id = id,
			eventName = eventName,
			x = x,
			y = y,
			width = width,
			height = height,
			isFixed = false,
			hasRange = false,
			borderRange = 0,
			action = nil,
			image = nil,
			_blockedPlayers = { }
		}, callback)

		if not hideCallback then
			self:display()
		end

		local instance = callback._instance
		instance._count = instance._count + 1
		instance[instance._count] = self
		instance[eventName] = instance._count

		return self
	end

	callback.textarea = function(self, playerName)
		if playerName then
			self._blockedPlayers[playerName] = false
		end

		ui.addTextArea(self.id, "<textformat leftmargin='1' rightmargin='1'><a href='event:callback." .. self.eventName .. "'>" .. str_rep('\n', self.height / 10), playerName, self.x - 5, self.y - 5, self.width + 5, self.height + 5, 1, 1, 0, self.isFixed)

		return self
	end

	callback.display = function(self, f)
		if type(f) ~= "function" then
			-- Nil, Nickname, ...
			self:textarea(f)
		else
			for playerName, data in next, tfm.get.room.playerList do
				if f(playerName, data) then
					self:textarea(playerName)
				end
			end
		end

		return self
	end

	callback.setFixed = function(self)
		self.isFixed = true
		return self
	end

	callback.setClickable = function(self, borderRange)
		if borderRange then
			self.borderRange = borderRange
		end
		self.hasRange = true

		return self
	end

	callback.inClickableRange = function(self, playerName, x, y)
		if self._blockedPlayers[playerName] then return end
		if not self.hasRange then
			-- Can be triggered in any position
			return true
		end

		return (
			(
				x >= (self.x - self.borderRange) and
				x <= (self.x + self.width + self.borderRange)
			) and
			(
				y >= (self.y - self.borderRange) and
				y <= (self.y + self.height + self.borderRange)
			)
		)
	end

	callback.setAction = function(self, action)
		self.action = action
		return self
	end

	callback.performAction = function(self, playerName, x, y, ...)
		if not self.action then return end
		if not self:inClickableRange(playerName, x, y) then return end

		return self:action(playerName, x, y, ...) -- self, playerName, x, y, ...
	end

	callback.setImage = function(self, imageId)
		self.image = imageId
		return self
	end

	callback.remove = function(self, playerName)
		if not playerName then
			if self.image then
				tfm.exec.removeImage(self.image)
			end
		else
			self._blockedPlayers[playerName] = true
		end

		ui.removeTextArea(self.id, playerName)
	end
end

local timer = { }
do
	timer.start = function(self, callback, ms, times, ...)
		local t = self._timers
		t._count = t._count + 1

		t[t._count] = {
			id = t._count,
			callback = callback,
			args = { ... },
			defaultMilliseconds = ms,
			milliseconds = ms,
			times = times
		}

		return t._count
	end

	timer.delete = function(self, id)
		local ts = self._timers
		ts[id] = nil
		ts._deleted = ts._deleted + 1
	end

	timer.loop = function(self)
		local ts = self._timers
		if ts._deleted >= ts._count then return end

		local t
		for i = 1, ts._count do
			t = ts[i]
			if t then
				t.milliseconds = t.milliseconds - 500
				if t.milliseconds <= 0 then
					t.milliseconds = t.defaultMilliseconds
					t.times = t.times - 1

					t.callback(tbl_unpack(t.args))

					if t.times == 0 then
						self:delete(i)
					end
				end
			end
		end
	end

	timer.refresh = function()
		timer._timers = {
			_count = 0,
			_deleted = 0
		}
	end
	timer.refresh()
end

local loadAllImages
loadAllImages = function(playerName, _src)
	for k, v in next, (_src or images) do
		if type(v) == "table" then
			loadAllImages(playerName, v)
		else
			tfm.exec.removeImage(tfm.exec.addImage(v, "_0", -10000, -10000, playerName))
		end
	end
end

local isEventWorkingFor = function(playerName)
	return playerCache[playerName] and playerCache[playerName].isDataLoaded
end

local canTriggerCallbacks = function(playerName)
	local cache = playerCache[playerName]
	local time = time()

	if cache.callbackAction > time then return end
	cache.callbackAction = time + 1200
	return true
end

ui.progressBar = function(playerName, progress, isBuilding)
	local barPosition = progressBarData[0]
	local x, y, w = barPosition.x, barPosition.y, barPosition.w - 55

	local barData = progressBarData[(isBuilding and 1 or 2)]

	progress = math.clamp(progress * (w / barData[1]), 1, w)
	ui.addTextArea(idEnums.progressBar, '', playerName, x - 2, y, w + 4, 8, barData[2], 0x57401B, 1, false)
	ui.addTextArea(idEnums.progressBar + 1, '', playerName, x, y + 2, progress, 4, barData[3], barData[3], 1, false)

	tfm.exec.addImage(images.cursor, "?2", x + w + 15, y - 5, playerName)
end
ui.removeProgressBar = function(playerName)
	for id = idEnums.progressBar, idEnums.progressBar + 1 do
		ui.removeTextArea(id, playerName)
	end
end

ui.displayCollectedItems = function(playerName)
	ui.addTextArea(idEnums.hud, "<p align='right'><font color='#000000' size='20'><B>" .. str_format("%03d", playerCache[playerName].collected), playerName, 715, 370, 80, nil, 1, 1, 0, true)
end

math.clamp = function(value, min, max)
	return value < min and min or value > max and max or value
end

string.split = function(str, separator, raw)
	local out, counter = { }, 0

	local strPos = 1
	local i, j
	while true do
		i, j = str_find(str, separator, strPos, raw)
		if not i then break end
		counter = counter + 1
		out[counter] = str_sub(str, strPos, i - 1)
		out[counter] = tonumber(out[counter]) or out[counter]

		strPos = j + 1
	end
	counter = counter + 1
	out[counter] = str_sub(str, strPos)
	out[counter] = tonumber(out[counter]) or out[counter]

	return out, counter
end

table.getRandomIndexes = function(list, n, avoidRepeated)
	local indexes, out = { }, { }

	local listLen, rand = #list

	for i = 1, n do
		if avoidRepeated then
			repeat
				rand = mt_random(listLen)
			until not indexes[rand]
			indexes[rand] = true

			out[i] = rand
		else
			out[i] = mt_random(listLen)
		end
	end

	return out
end

local displayHitCircle = function(playerName, id, x, y)
	local i, xOffset, yOffset = 0
	for b = 0, 22, 5 do
		i = i + 1

		xOffset = mt_cos(b) * 15
		yOffset = mt_sin(b) * 15

		tfm.exec.addBonus(0, x + xOffset, y + yOffset , id + i, 0, false, playerName)
	end
end

local removeHitCircle = function(playerName, id)
	for b = 1, 5 do
		tfm.exec.removeBonus(id + b, playerName)
	end
end

local teleportCollectablesParticles
do
	local particles = { 21, 22, 23, 24, 21, 22, 23, 24, 29, 30, 31, 32, 34 }

	teleportCollectablesParticles = function(playerName, x, y, disappear)
		disappear = disappear and 1 or -1

		local cos, sin
		for i = 1, 25 do
			cos = mt_cos(i)
			sin = mt_sin(i)

			tfm.exec.displayParticle(particles[mt_random(#particles)], x + cos * 30, y + sin * 30,
				disappear*cos * 4, disappear*sin * 4, disappear*-cos * .5, disappear*-sin * .5, playerName)
		end
	end
end

local giveTitle = function(playerName)
	system.giveEventGift(playerName, module.reward)
	playerData
		:set(playerName, "finishedEvent", true)
		:save(playerName)
	tfm.exec.giveConsumables(playerName, consumables[mt_random(#consumables)], 5)
end

--[[ System ]]--
local getImageStage = function(score, targetScore, len)
	local stage = mt_ceil(score+.1) / (targetScore / (len - 1))
	return math.clamp(mt_ceil(stage), 1, len)
end

local trio, updateTrioImage, displayTrio, onTrioClick, displayInstrumentsSequence
local trioCallback = function()
	trio = callback
		.new("trio", 540, 115, 530, 265, true)
		:setClickable()
		:setAction(onTrioClick)

	progressBarData[0] = {
		x = trio.x + 70,
		y = trio.y,
		w = trio.width - 105
	}
end

updateTrioImage = function(playerName, targetScore)
	local cache = playerCache[playerName]
	local collectedItems = playerData:get(playerName, "collected")

	local imageStage = getImageStage(collectedItems, targetScore, #cache.imageCollection)
	if not cache.currentTrioStage or cache.currentTrioStage ~= imageStage then
		if cache.images.trio then
			tfm.exec.removeImage(cache.images.trio)
		end
		cache.images.trio = tfm.exec.addImage(cache.imageCollection[imageStage], "?2", 0, 0, playerName)

		cache.currentTrioStage = imageStage
	end

	return collectedItems
end

displayTrio = function(playerName, targetScore, notClickable)
	if not notClickable then
		trio
			:textarea(playerName)
	end

	return updateTrioImage(playerName, targetScore)
end

onTrioClick = function(self, playerName, _, _, _, cache)
	if cache.instrumentCorrectSequence and not cache.sequenceCompleted then
		displayInstrumentsSequence(playerName, cache)
	end
	if cache.collected == 0 then return end

	local totalCollected = playerData:get(playerName, "collected") + cache.collected
	playerData:set(playerName, "collected", totalCollected)
	cache.collected = 0

	local isBuilding = playerData:get(playerName, "buildingTrio")

	ui.displayCollectedItems(playerName)
	ui.progressBar(playerName, totalCollected, isBuilding)

	if isBuilding then -- objects
		updateTrioImage(playerName, module.pieces_to_build_trio)

		if totalCollected >= module.pieces_to_build_trio then
			playerData
				:set(playerName, "buildingTrio", false)
				:set(playerName, "collected", 0)

			cache.isDataLoaded = false -- prevents the player from triggering other callbacks

			tfm.exec.giveConsumables(playerName, consumables[mt_random(#consumables)], 3)
		end
	else -- decorations
		updateTrioImage(playerName, module.decorations_to_finish_trio)

		if totalCollected >= module.decorations_to_finish_trio then
			cache.isDataLoaded = false

			tfm.exec.giveConsumables(playerName, consumables[mt_random(#consumables)], 2)
		end
	end

	playerData:save(playerName)
end

local instrumentCbk, onInstrumentClick = { }
local instrumentsCallback = function()
	local position
	for i = 1, #instrumentPositions do
		position = instrumentPositions[i]

		instrumentCbk[i] = callback
			.new("instrument_" .. i, position[1], position[2], position[3], position[4], true)
			:setAction(onInstrumentClick)
			:setFixed()
		instrumentCbk[i].__id = i
	end
end

local displayAllInstruments = function(playerName)
	local cache = playerCache[playerName]
	local imageCache = cache.images.instruments
	local instrumentImages = images.instruments

	ui.addTextArea(idEnums.background, '', playerName, -2500, -2500, 5000, 5000, 1, 1, .6, false)

	local position
	for i = 1, #instrumentPositions do
		position = instrumentPositions[i]
		imageCache[i] = tfm.exec.addImage(instrumentImages[-i], ":0", position[1], position[2], playerName)
	end
end

local enableAllInstruments = function(playerName)
	for i = 1, #instrumentPositions do
		instrumentCbk[i]:textarea(playerName)
	end
end

local removeAllInstruments = function(playerName, cache)
	local imageCache = cache.images.instruments
	for i = 1, #imageCache do
		tfm.exec.removeImage(imageCache[i])
		instrumentCbk[i]:remove(playerName)
	end
	ui.removeTextArea(idEnums.background, playerName)
end

onInstrumentClick = function(self, playerName, _, _, _, cache, isTransparent, ignoreAttempt)
	if cache.instrumentSelectionTime > 0 or cache.sequenceCompleted then return end

	local id = tonumber(self) or self.__id
	local imageCache = cache.images.instruments
	local position = instrumentPositions[id]

	tfm.exec.removeImage(imageCache[id])
	imageCache[id] = tfm.exec.addImage(images.instruments[id * (isTransparent and -1 or 1)], ":0", position[1], position[2], playerName)

	if isTransparent then return end
	cache.instrumentSelectedId = id
	cache.instrumentSelectionTime = 1000

	if ignoreAttempt then return end
	local attemptSequence = cache.instrumentSequence
	cache.instrumentSequenceCount = cache.instrumentSequenceCount + 1
	attemptSequence[cache.instrumentSequenceCount] = id

	if cache.instrumentSequenceCount < module.total_instrument_sequences then return end
	local correctSequence, correctSequenceIndex = cache.instrumentCorrectSequence, 0
	for s = cache.instrumentSequenceCount - module.total_instrument_sequences + 1, cache.instrumentSequenceCount do
		correctSequenceIndex = correctSequenceIndex + 1
		if attemptSequence[s] ~= correctSequence[correctSequenceIndex] then return end
	end
	cache.sequenceCompleted = true

	giveTitle(playerName)
end

displayInstrumentsSequence = function(playerName, cache)
	local sequence = cache.instrumentCorrectSequence
	displayAllInstruments(playerName)

	for s = 1, module.total_instrument_sequences do
		timer:start(onInstrumentClick, 2000 + (s * 1500), 1, sequence[s], playerName, 0, 0, 0, cache, false, true)
	end
	timer:start(enableAllInstruments, 2000 + ((module.total_instrument_sequences + 1) * 1500), 1, playerName)
end

local emotesCbk, onEmoteClick = { }
local emoteCallbacks = function()
	local imagesLen, x = 0
	for name in next, images.emotes do
		imagesLen = imagesLen + 1
		x = totalEmotes + imagesLen*45

		emotesCbk[name] = callback
			.new("emote_" .. name, x, 25, 40, 40, true)
			:setAction(onEmoteClick)
			:setFixed()
		emotesCbk[name].__id = tfm.enum.emote[name]
	end
end

local displayAllEmotes = function(playerName)
	local img
	for name, image in next, images.emotes do
		img = emotesCbk[name]
		tfm.exec.addImage(image, ":1", img.x, img.y, playerName)
		img:textarea(playerName)
	end
end

onEmoteClick = function(self, playerName)
	tfm.exec.playEmote(playerName, self.__id)
end

local spawnCollectables = function(playerName, imgSrc, enableTeleport)
	local cache = playerCache[playerName]
	local imageCache = cache.images.collectables
	local collectablePositions = { }

	local spawnPositions, spawnPositionIndex, spawnPosition = table.getRandomIndexes(objectSpawnPoints, cache.totalCollectablesOnMap, true)
	local x, y, randomObjectIndex, id

	for p = 1, cache.totalCollectablesOnMap do
		spawnPositionIndex = spawnPositions[p]
		collectablePositions[spawnPositionIndex] = true

		spawnPosition = objectSpawnPoints[spawnPositionIndex]

		x, y = spawnPosition[1], spawnPosition[2]
		randomObjectIndex = mt_random(#imgSrc)

		id = p * 100
		displayHitCircle(playerName, id, x + 20, y + 20)

		x, y = x - 20, y - 20
		imageCache[p] = {
			id = id,
			imageId = tfm.exec.addImage(imgSrc[randomObjectIndex], "?100", x, y, playerName),
			randomObjectIndex = randomObjectIndex,
			x = x,
			y = y,
			imgSrc = imgSrc,
			spawnPositionIndex = spawnPositionIndex,
			isActive = true,
			teleportTime = enableTeleport and mt_random(module.time_to_teleport_collectables - 3000, module.time_to_teleport_collectables + 3000) or nil
		}
	end

	if enableTeleport then
		cache.collectablePositions = collectablePositions
		cache.teleportingCollectables = true
	end

	return imgSrc
end

local teleportCollectable = function(playerName, cache, collectable)
	collectable.isActive = false

	local collectablePositions = cache.collectablePositions

	local totalSpawnPoints, randomSpawnPointIndex = #objectSpawnPoints
	repeat
		randomSpawnPointIndex = mt_random(totalSpawnPoints)
	until not collectablePositions[randomSpawnPointIndex]
	local randomSpawnPoint = objectSpawnPoints[randomSpawnPointIndex]

	removeHitCircle(playerName, collectable.id)

	teleportCollectablesParticles(playerName, collectable.x + 20, collectable.y + 20, true)
	teleportCollectablesParticles(playerName, randomSpawnPoint[1], randomSpawnPoint[2], false)

	tfm.exec.removeImage(collectable.imageId)

	collectable.x = randomSpawnPoint[1] - 20
	collectable.y = randomSpawnPoint[2] - 20

	collectablePositions[randomSpawnPointIndex], collectablePositions[collectable.spawnPositionIndex] = true, nil
	collectable.spawnPositionIndex = randomSpawnPointIndex

	displayHitCircle(playerName, collectable.id, randomSpawnPoint[1] + 20, randomSpawnPoint[2] + 20)
	collectable.imageId = tfm.exec.addImage(collectable.imgSrc[collectable.randomObjectIndex], "?100", collectable.x, collectable.y, playerName)

	collectable.isActive = true
end

--[[ Events ]]--
local hasLoaded = false
eventNewGame = function()
	if hasLoaded then
		return system.exit()
	end
	hasLoaded = true

	tfm.exec.setGameTime(module.time)
	ui.setMapName(translation.carnival)

	loadAllImages()
	trioCallback()
	instrumentsCallback()
	emoteCallbacks()

	for playerName in next, tfm.get.room.playerList do
		playerCache[playerName] = {
			collected = 0,
			totalCollectablesOnMap = 0,
			collectablePositions = { },
			teleportingCollectables = false,

			currentTrioStage = nil,
			imageCollection = nil,

			instrumentCorrectSequence = nil,
			instrumentSequenceCount = 0,
			instrumentSequence = { },
			instrumentSelectedId = 0,
			instrumentSelectionTime = 0,
			sequenceCompleted = false,

			images = {
				trio = nil,
				collectables = { },
				instruments = { }
			},

			callbackAction = 0,
			isDataLoaded = false
		}

		system.loadPlayerData(playerName)
	end
	tfm.exec.addImage(module.map.background, "?0", 0, 0)
end

eventPlayerDataLoaded = function(playerName, data)
	playerData:newPlayer(playerName, data)

	local cache = playerCache[playerName]

	local isBuilding, collectedItem, imgSrc
	if playerData:get(playerName, "buildingTrio") then
		isBuilding = true
		cache.imageCollection = images.trioBuilding
		cache.totalCollectablesOnMap = mt_floor(#objectSpawnPoints * .8)

		collectedItems = displayTrio(playerName, module.pieces_to_build_trio)
		imgSrc = spawnCollectables(playerName, images.trioPieces, false)

		tfm.exec.chatMessage("<font color='#D1E42B'>" .. translation.buildTrio .. translation.credits .. "</font>", playerName)
	else
		cache.imageCollection = images.trioDecorating
		cache.totalCollectablesOnMap = mt_floor(#objectSpawnPoints * .5)

		local eventConcluded = playerData:get(playerName, "finishedEvent")

		collectedItems = displayTrio(playerName, module.decorations_to_finish_trio, eventConcluded)

		if playerData:get(playerName, "collected") < module.decorations_to_finish_trio then
			imgSrc = spawnCollectables(playerName, images.trioDecorations, true)
			tfm.exec.chatMessage("<font color='#D1E42B'>" .. translation.decorateTrio .. translation.credits .. "</font>", playerName)
		elseif not eventConcluded then -- instruments
			cache.instrumentCorrectSequence = table.getRandomIndexes(instrumentPositions, module.total_instrument_sequences, false)
			tfm.exec.chatMessage("<font color='#D1E42B'>" .. translation.playInstruments .. translation.credits .. "</font>", playerName)
		else -- player finished
			displayAllEmotes(playerName)
			tfm.exec.chatMessage("<font color='#D1E42B'>" .. translation.finished .. translation.credits .. "</font>", playerName)
		end
	end

	if imgSrc then
		ui.progressBar(playerName, collectedItems, isBuilding)

		tfm.exec.addImage(imgSrc[0], "&100", 720, 372, playerName)
		ui.displayCollectedItems(playerName)
	end

	cache.isDataLoaded = true
end

eventPlayerBonusGrabbed = function(playerName, id)
	local cache = playerCache[playerName]

	local imageCache = cache.images.collectables
	local pieceId = mt_floor(id / 100)
	if not imageCache[pieceId].isActive then return end

	local cachedImage = imageCache[pieceId]
	tfm.exec.removeImage(cachedImage.imageId)
	tfm.exec.addImage(cachedImage.imgSrc[-cachedImage.randomObjectIndex], "?100", cachedImage.x, cachedImage.y, playerName)
	cachedImage.isActive = false

	cache.collected = cache.collected + 1
	cache.totalCollectablesOnMap = cache.totalCollectablesOnMap - 1
	ui.displayCollectedItems(playerName)

	removeHitCircle(playerName, cachedImage.id)
end

eventTextAreaCallback = function(id, playerName, eventName)
	if not (isEventWorkingFor(playerName) and canTriggerCallbacks(playerName)) then return end

	if str_find(eventName, "callback.", 1, true) then
		local data = tfm.get.room.playerList[playerName]

		callback.__get(str_sub(eventName, 10))
			:performAction(playerName, data.x, data.y, data, playerCache[playerName])
	end
end

eventNewPlayer = function(playerName)
	loadAllImages(playerName)
	tfm.exec.addImage(module.map.background, "?0", 0, 0, playerName)
end

eventLoop = function()
	for playerName, data in next, playerCache do
		-- check for teleporting collectables
		if data.teleportingCollectables and data.totalCollectablesOnMap > 0 then
			for k, v in next, data.images.collectables do
				if v.isActive then
					v.teleportTime = v.teleportTime - 500

					if v.teleportTime <= 0 then
						v.teleportTime = mt_random(module.time_to_teleport_collectables - 3000, module.time_to_teleport_collectables + 3000)
						teleportCollectable(playerName, data, v)
					end
				end
			end
		-- check for selected instruments
		elseif data.instrumentSelectionTime > 0 then
			data.instrumentSelectionTime = data.instrumentSelectionTime - 500
			if data.instrumentSelectionTime <= 0 then
				onInstrumentClick(data.instrumentSelectedId, playerName, nil, nil, nil, data, true)

				if data.sequenceCompleted then
					removeAllInstruments(playerName, data)
				end
			end
		end
	end

	timer:loop()
end

--[[ Init ]]--
tfm.exec.disableAfkDeath()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableDebugCommand()
tfm.exec.disableMortCommand()
tfm.exec.disablePhysicalConsumables()

tfm.exec.newGame(module.map.xml)
