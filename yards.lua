local lib = LibStub("LibCoordinator-1.0", 1)

-- Making Coordinator global,
-- the library acts basically as the core
Coordinator = lib

local WorldMapSize

function lib.ToYards(relToPlayer, x, y, z)
	local zone = GetMapInfo()

	if(not relToPlayer) then
		local plrX, plrY = GetPlayerMapPosition("player")
		x, y = -x+plrX, y-plrY
	end

	local data = WorldMapSize[zone]
	if(not data) then return x*1000, y*1000, z end
	return data.width*x, data.height*y, z
end

WorldMapSize = {
	Ashenvale = {
		height = 3843.722331667447,
		width = 5766.728885829694,
	},
	Aszhara = {
		height = 3381.22554790382,
		width = 5070.886912363937,
	},
	AzuremystIsle = {
		height = 2714.563862990522,
		width = 4070.87719998905,
	},
	Barrens = {
		height = 6756.201888541853,
		width = 10133.44231353798,
	},
	BloodmystIsle = {
		height = 2174.984213312164,
		width = 3262.535628257626,
	},
	Darkshore = {
		height = 4366.635262519317,
		width = 6550.07142937905,
	},
	Darnassis = {
		height = 705.7244742259542,
		width = 1058.344272032854,
	},
	Desolace = {
		height = 2997.895112390325,
		width = 4495.882561567951,
	},
	Durotar = {
		height = 3524.975103516492,
		width = 5287.556393263762,
	},
	Dustwallow = {
		height = 3499.975024621409,
		width = 5250.057340719384,
	},
	Felwood = {
		height = 3833.30578953572,
		width = 5750.062500603067,
	},
	Feralas = {
		height = 4633.300220031075,
		width = 6950.07476479001,
	},
	Moonglade = {
		height = 1539.572004392277,
		width = 2308.359613919473,
	},
	Mulgore = {
		height = 3424.975591847491,
		width = 5137.555664509726,
	},
	Ogrimmar = {
		height = 935.4097495193695,
		width = 1402.619172463506,
	},
	Silithus = {
		height = 2322.900917404436,
		width = 3483.371660836989,
	},
	StonetalonMountains = {
		height = 3256.22685709556,
		width = 4883.386126224323,
	},
	Tanaris = {
		height = 4599.967247105565,
		width = 6900.075410478199,
	},
	Teldrassil = {
		height = 3393.725685278266,
		width = 5091.720159017256,
	},
	TheExodar = {
		height = 704.6827795715492,
		width = 1056.782908333002,
	},
	ThousandNeedles = {
		height = 2933.311990587089,
		width = 4400.046926738385,
	},
	ThunderBluff = {
		height = 695.8286363220358,
		width = 1043.761162566134,
	},
	UngoroCrater = {
		height = 2466.648940830691,
		width = 3700.039952384531,
	},
	Winterspring = {
		height = 4733.299352687333,
		width = 7100.076688034489,
	},
	Alterac = {
		height = 1866.674220583334,
		width = 2799.999464405289,
	},
	Arathi = {
		height = 2400.009317069356,
		width = 3599.999517304195,
	},
	Badlands = {
		height = 1658.340337615859,
		width = 2487.500569928747,
	},
	BlastedLands = {
		height = 2233.342487048268,
		width = 3349.999380719363,
	},
	BurningSteppes = {
		height = 1952.091015081907,
		width = 2929.167049647848,
	},
	DeadwindPass = {
		height = 1666.673717206878,
		width = 2499.999255461505,
	},
	DunMorogh = {
		height = 3283.346244075043,
		width = 4925.000979131685,
	},
	Duskwood = {
		height = 1800.007435102674,
		width = 2699.999451812027,
	},
	EasternPlaguelands = {
		height = 2687.510259086504,
		width = 4031.248684963022,
	},
	Elwynn = {
		height = 2314.592478810788,
		width = 3470.832795915813,
	},
	EversongWoods = {
		height = 3283.346090242183,
		width = 4925.00271131707,
	},
	Ghostlands = {
		height = 2200.008615840919,
		width = 3300.001914001321,
	},
	Hilsbrad = {
		height = 2133.341648261057,
		width = 3199.998998314975,
	},
	Hinterlands = {
		height = 2566.6767425107,
		width = 3849.999302583992,
	},
	Ironforge = {
		height = 527.6066263822604,
		width = 790.625237342102,
	},
	LochModan = {
		height = 1839.589436540107,
		width = 2758.333078630792,
	},
	Redridge = {
		height = 1447.921846941264,
		width = 2170.833008876805,
	},
	SearingGorge = {
		height = 1487.505327445583,
		width = 2231.249676776115,
	},
	SilvermoonCity = {
		height = 806.7736903384404,
		width = 1211.459296502504,
	},
	Silverpine = {
		height = 2800.0110500699,
		width = 4199.999060067367,
	},
	Stormwind = {
		height = 1158.337650999629,
		width = 1737.500553362899,
	},
	Stranglethorn = {
		height = 4254.183097414531,
		width = 6381.247773741421,
	},
	Sunwell = {
		height = 2218.75784157939,
		width = 3327.080984022923,
	},
	SwampOfSorrows = {
		height = 1529.173582734637,
		width = 2293.750686253685,
	},
	Tirisfal = {
		height = 3012.512329627232,
		width = 4518.747902731258,
	},
	Undercity = {
		height = 640.1066040851099,
		width = 959.3745478926886,
	},
	WesternPlaguelands = {
		height = 2866.677851772014,
		width = 4299.999720893135,
	},
	Westfall = {
		height = 2333.342511708478,
		width = 3499.999662793482,
	},
	Wetlands = {
		height = 2756.260945423485,
		width = 4135.416085415621,
	},
	BladesEdgeMountains = {
		height = 3616.553525584605,
		width = 5424.971374542539,
	},
	Hellfire = {
		height = 3443.64230460125,
		width = 5164.556244744065,
	},
	Nagrand = {
		height = 3683.218433421437,
		width = 5524.971116484553,
	},
	Netherstorm = {
		height = 3716.550667470386,
		width = 5574.970542741407,
	},
	ShadowmoonValley = {
		height = 3666.551832578994,
		width = 5499.971055470069,
	},
	ShattrathCity = {
		height = 870.8062268244973,
		width = 1306.243111124071,
	},
	TerokkarForest = {
		height = 3599.887549731843,
		width = 5399.971897226099,
	},
	Zangarmarsh = {
		height = 3351.978661481413,
		width = 5027.057239215307,
	},
	BoreanTundra = {
		height = 3843.764953143499,
		width = 5764.582303295793,
	},
	CrystalsongForest = {
		height = 1814.590295101352,
		width = 2722.916513743646,
	},
	Dalaran = {
		height = 553.3418567935553,
		width = 830.0149393375432,
	},
	Dragonblight = {
		height = 3739.598062842169,
		width = 5608.332396545997,
	},
	GrizzlyHills = {
		height = 3500.013689934217,
		width = 5249.998732532693,
	},
	HrothgarsLanding = {
		height = 2452.093653509858,
		width = 3677.082560623348,
	},
	HowlingFjord = {
		height = 4031.265457002443,
		width = 6045.831836878359,
	},
	IcecrownGlacier = {
		height = 4181.266519840844,
		width = 6270.832975322177,
	},
	LakeWintergrasp = {
		height = 1983.341134082619,
		width = 2974.99948105957,
	},
	SholazarBasin = {
		height = 2904.178067737769,
		width = 4356.249510482578,
	},
	TheStormPeaks = {
		height = 4741.684740041381,
		width = 7112.498187401986,
	},
	ZulDrak = {
		height = 3329.179762967791,
		width = 4993.749118857795,
	},
}