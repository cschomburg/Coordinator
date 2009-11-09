local WorldMapSize

function Coordinator:ToYards(x, y, z)
	local cont = GetCurrentMapContinent()
	local zone = GetMapInfo()
	if(zone == "WarsongGulch") then
		return 1000*x, 1000*y, z
	end

	local data = WorldMapSize[cont] and WorldMapSize[cont].zoneData and WorldMapSize[cont].zoneData[zone]
	if(not data) then return end

	return data.width*x, data.height*y, z
end

WorldMapSize = {
	-- World Map of Azeroth
	[0] = {
		parentContinent = 0,
		height = 31809.64857610083,
		width = 47714.278579261,
	},
	-- Kalimdor
	{ -- [1]
		parentContinent = 0,
		height = 24533.025279205,
		width = 36800.210572494,
		xOffset = -8590.40725049343,
		yOffset = 5628.692856102324,
		zoneData = {
			Ashenvale = {
				height = 3843.722331667447,
				width = 5766.728885829694,
				xOffset = 15366.76675592628,
				yOffset = 8126.925930315996,
			},
			Aszhara = {
				height = 3381.22554790382,
				width = 5070.886912363937,
				xOffset = 20343.90431905976,
				yOffset = 7458.18074892042,
			},
			AzuremystIsle = {
				height = 2714.563862990522,
				width = 4070.87719998905,
				xOffset = 9966.708003150136,
				yOffset = 5460.278492344226,
			},
			Barrens = {
				height = 6756.201888541853,
				width = 10133.44231353798,
				xOffset = 14443.84040901447,
				yOffset = 11187.32063797497,
			},
			BloodmystIsle = {
				height = 2174.984213312164,
				width = 3262.535628257626,
				xOffset = 9541.702868577344,
				yOffset = 3424.87645454774,
			},
			Darkshore = {
				height = 4366.635262519317,
				width = 6550.07142937905,
				xOffset = 14125.0864431955,
				yOffset = 4466.535577798089,
			},
			Darnassis = {
				height = 705.7244742259542,
				width = 1058.344272032854,
				xOffset = 14128.39058434346,
				yOffset = 2561.565704787642,
			},
			Desolace = {
				height = 2997.895112390325,
				width = 4495.882561567951,
				xOffset = 12833.40568925697,
				yOffset = 12347.7291386989,
			},
			Durotar = {
				height = 3524.975103516492,
				width = 5287.556393263762,
				xOffset = 19029.30641831177,
				yOffset = 10991.48866520544,
			},
			Dustwallow = {
				height = 3499.975024621409,
				width = 5250.057340719384,
				xOffset = 18041.79555525144,
				yOffset = 14833.12785083746,
			},
			Felwood = {
				height = 3833.30578953572,
				width = 5750.062500603067,
				xOffset = 15425.10050841866,
				yOffset = 5666.52696052216,
			},
			Feralas = {
				height = 4633.300220031075,
				width = 6950.07476479001,
				xOffset = 11625.05968863682,
				yOffset = 15166.45859885191,
			},
			Moonglade = {
				height = 1539.572004392277,
				width = 2308.359613919473,
				xOffset = 18448.04941280923,
				yOffset = 4308.203668830446,
			},
			Mulgore = {
				height = 3424.975591847491,
				width = 5137.555664509726,
				xOffset = 15018.84638430639,
				yOffset = 13072.72374939454,
			},
			Ogrimmar = {
				height = 935.4097495193695,
				width = 1402.619172463506,
				xOffset = 20747.42615230776,
				yOffset = 10525.94819392488,
			},
			Silithus = {
				height = 2322.900917404436,
				width = 3483.371660836989,
				xOffset = 14529.25779832084,
				yOffset = 18758.10034739171,
			},
			StonetalonMountains = {
				height = 3256.22685709556,
				width = 4883.386126224323,
				xOffset = 13820.91659894445,
				yOffset = 9883.163451643639,
			},
			Tanaris = {
				height = 4599.967247105565,
				width = 6900.075410478199,
				xOffset = 17285.53717337067,
				yOffset = 18674.76738951156,
			},
			Teldrassil = {
				height = 3393.725685278266,
				width = 5091.720159017256,
				xOffset = 13252.16118637725,
				yOffset = 968.6435100517717,
			},
			TheExodar = {
				height = 704.6827795715492,
				width = 1056.782908333002,
				xOffset = 10533.08067788734,
				yOffset = 6276.205943683332,
			},
			ThousandNeedles = {
				height = 2933.311990587089,
				width = 4400.046926738385,
				xOffset = 17500.12330544135,
				yOffset = 16766.44742072096,
			},
			ThunderBluff = {
				height = 695.8286363220358,
				width = 1043.761162566134,
				xOffset = 16550.11296988024,
				yOffset = 13649.80296445508,
			},
			UngoroCrater = {
				height = 2466.648940830691,
				width = 3700.039952384531,
				xOffset = 16533.4461782123,
				yOffset = 18766.43318304924,
			},
			Winterspring = {
				height = 4733.299352687333,
				width = 7100.076688034489,
				xOffset = 17383.45536235255,
				yOffset = 4266.537029274375,
			},
		},
	},
	-- Eastern Kingdoms
	{ -- [2]
		parentContinent = 0,
		height = 27149.795290881,
		width = 40741.175327834,
		xOffset = 18542.31220836664,
		yOffset = 3585.574573158966,
		zoneData = {
			Alterac = {
				height = 1866.674220583334,
				width = 2799.999464405289,
				xOffset = 17388.63468066122,
				yOffset = 9676.382149825957,
			},
			Arathi = {
				height = 2400.009317069356,
				width = 3599.999517304195,
				xOffset = 19038.63447926361,
				yOffset = 11309.72195295708,
			},
			Badlands = {
				height = 1658.340337615859,
				width = 2487.500569928747,
				xOffset = 20251.13345045087,
				yOffset = 17065.99453090572,
			},
			BlastedLands = {
				height = 2233.342487048268,
				width = 3349.999380719363,
				xOffset = 19413.63423284709,
				yOffset = 21743.09620559562,
			},
			BurningSteppes = {
				height = 1952.091015081907,
				width = 2929.167049647848,
				xOffset = 18438.63415866318,
				yOffset = 18207.66550773985,
			},
			DeadwindPass = {
				height = 1666.673717206878,
				width = 2499.999255461505,
				xOffset = 19005.30099399293,
				yOffset = 21043.09319963172,
			},
			DunMorogh = {
				height = 3283.346244075043,
				width = 4925.000979131685,
				xOffset = 16369.88372014602,
				yOffset = 15053.48652833869,
			},
			Duskwood = {
				height = 1800.007435102674,
				width = 2699.999451812027,
				xOffset = 17338.63474984946,
				yOffset = 20893.09262994406,
			},
			EasternPlaguelands = {
				height = 2687.510259086504,
				width = 4031.248684963022,
				xOffset = 20459.46800337001,
				yOffset = 7472.207074316265,
			},
			Elwynn = {
				height = 2314.592478810788,
				width = 3470.832795915813,
				xOffset = 16636.55146195304,
				yOffset = 19116.00248086271,
			},
			EversongWoods = {
				height = 3283.346090242183,
				width = 4925.00271131707,
				xOffset = 20259.46550654072,
				yOffset = 2534.687768168357,
			},
			Ghostlands = {
				height = 2200.008615840919,
				width = 3300.001914001321,
				xOffset = 21055.29898547313,
				yOffset = 5309.698628620597,
			},
			Hilsbrad = {
				height = 2133.341648261057,
				width = 3199.998998314975,
				xOffset = 17105.30161317513,
				yOffset = 10776.38647689923,
			},
			Hinterlands = {
				height = 2566.6767425107,
				width = 3849.999302583992,
				xOffset = 19746.96759079755,
				yOffset = 9709.715638073398,
			},
			Ironforge = {
				height = 527.6066263822604,
				width = 790.625237342102,
				xOffset = 18885.55918004965,
				yOffset = 15745.64757909506,
			},
			LochModan = {
				height = 1839.589436540107,
				width = 2758.333078630792,
				xOffset = 20165.71744013867,
				yOffset = 15663.90644131906,
			},
			Redridge = {
				height = 1447.921846941264,
				width = 2170.833008876805,
				xOffset = 19742.80073199006,
				yOffset = 19751.42200372843,
			},
			SearingGorge = {
				height = 1487.505327445583,
				width = 2231.249676776115,
				xOffset = 18494.88412729142,
				yOffset = 17276.41249042905,
			},
			SilvermoonCity = {
				height = 806.7736903384404,
				width = 1211.459296502504,
				xOffset = 22172.71642224908,
				yOffset = 3422.648306718702,
			},
			Silverpine = {
				height = 2800.0110500699,
				width = 4199.999060067367,
				xOffset = 14721.96859379216,
				yOffset = 9509.714862642681,
			},
			Stormwind = {
				height = 1158.337650999629,
				width = 1737.500553362899,
				xOffset = 16449.05109973784,
				yOffset = 19172.25293704512,
			},
			Stranglethorn = {
				height = 4254.183097414531,
				width = 6381.247773741421,
				xOffset = 15951.13530113703,
				yOffset = 22345.18245588815,
			},
			Sunwell = {
				height = 2218.75784157939,
				width = 3327.080984022923,
				xOffset = 21074.05125342849,
				yOffset = 7.594755912743345,
			},
			SwampOfSorrows = {
				height = 1529.173582734637,
				width = 2293.750686253685,
				xOffset = 20394.88344424886,
				yOffset = 20797.25895394673,
			},
			Tirisfal = {
				height = 3012.512329627232,
				width = 4518.747902731258,
				xOffset = 15138.6360714653,
				yOffset = 7338.872677268415,
			},
			Undercity = {
				height = 640.1066040851099,
				width = 959.3745478926886,
				xOffset = 17298.77542115219,
				yOffset = 9298.435370484816,
			},
			WesternPlaguelands = {
				height = 2866.677851772014,
				width = 4299.999720893135,
				xOffset = 17755.30124459509,
				yOffset = 7809.708293788776,
			},
			Westfall = {
				height = 2333.342511708478,
				width = 3499.999662793482,
				xOffset = 15155.30169114852,
				yOffset = 20576.42535247717,
			},
			Wetlands = {
				height = 2756.260945423485,
				width = 4135.416085415621,
				xOffset = 18561.55114967782,
				yOffset = 13324.31325114659,
			},
		},
	},
	-- Outland
	{ -- [3]
		parentContinent = 3,
		height = 11642.355227091,
		width = 17463.987300595,
		zoneData = {
			BladesEdgeMountains = {
				height = 3616.553525584605,
				width = 5424.971374542539,
				xOffset = 4150.184588602209,
				yOffset = 1412.982196881336,
			},
			Hellfire = {
				height = 3443.64230460125,
				width = 5164.556244744065,
				xOffset = 7456.417231266903,
				yOffset = 4339.973859432732,
			},
			Nagrand = {
				height = 3683.218433421437,
				width = 5524.971116484553,
				xOffset = 2700.192056890117,
				yOffset = 5779.512082963144,
			},
			Netherstorm = {
				height = 3716.550667470386,
				width = 5574.970542741407,
				xOffset = 7512.666973902843,
				yOffset = 365.0979868806522,
			},
			ShadowmoonValley = {
				height = 3666.551832578994,
				width = 5499.971055470069,
				xOffset = 8770.993482940312,
				yOffset = 7769.033432511459,
			},
			ShattrathCity = {
				height = 870.8062268244973,
				width = 1306.243111124071,
				xOffset = 6860.744657085816,
				yOffset = 7295.086006462451,
			},
			TerokkarForest = {
				height = 3599.887549731843,
				width = 5399.971897226099,
				xOffset = 5912.67529110344,
				yOffset = 6821.146327166267,
			},
			Zangarmarsh = {
				height = 3351.978661481413,
				width = 5027.057239215307,
				xOffset = 3521.020775148071,
				yOffset = 3885.821395736634,
			},
		},
	},
	-- Northrend
	{ -- [4]
		parentContinent = 0,
		height = 11834.3119870532,
		width = 17751.3962441049,
		xOffset = 16020.94044398222,
		yOffset = 454.2451915717977,
		zoneData = {
			BoreanTundra = {
				height = 3843.764953143499,
				width = 5764.582303295793,
				xOffset = 646.3192474426043,
				yOffset = 5695.48114050537,
			},
			CrystalsongForest = {
				height = 1814.590295101352,
				width = 2722.916513743646,
				xOffset = 7773.401390128443,
				yOffset = 4091.308181657137,
			},
			Dalaran = {
				height = 553.3418567935553,
				width = 830.0149393375432,
				xOffset = 8164.641313001377,
				yOffset = 4526.723129621716,
			},
			Dragonblight = {
				height = 3739.598062842169,
				width = 5608.332396545997,
				xOffset = 5590.068422600026,
				yOffset = 5018.394866268677,
			},
			GrizzlyHills = {
				height = 3500.013689934217,
				width = 5249.998732532693,
				xOffset = 10327.56786162186,
				yOffset = 5076.728707808831,
			},
			HrothgarsLanding = {
				height = 2452.093653509858,
				width = 3677.082560623348,
				xOffset = 6419.234857391856,
				yOffset = -187.8757232657943,
			},
			HowlingFjord = {
				height = 4031.265457002443,
				width = 6045.831836878359,
				xOffset = 10615.0679627145,
				yOffset = 7476.73831512609,
			},
			IcecrownGlacier = {
				height = 4181.266519840844,
				width = 6270.832975322177,
				xOffset = 3773.401695036191,
				yOffset = 1166.296622984233,
			},
			LakeWintergrasp = {
				height = 1983.341134082619,
				width = 2974.99948105957,
				xOffset = 4887.98528918423,
				yOffset = 4876.727878058311,
			},
			SholazarBasin = {
				height = 2904.178067737769,
				width = 4356.249510482578,
				xOffset = 2287.985538503677,
				yOffset = 3305.888591396293,
			},
			TheStormPeaks = {
				height = 4741.684740041381,
				width = 7112.498187401986,
				xOffset = 7375.484940713573,
				yOffset = 395.46058562991,
			},
			ZulDrak = {
				height = 3329.179762967791,
				width = 4993.749118857795,
				xOffset = 9817.151095677416,
				yOffset = 2924.637042390465,
			},
		},
	},
}