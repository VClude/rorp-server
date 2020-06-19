Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = {'police'},
		locked = false,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_ph_door01'), objHeading = 270.0, objCoords = vector3(434.7, -980.6, 30.8)},
			{objHash = GetHashKey('v_ilev_ph_door002'), objHeading = 270.0, objCoords = vector3(434.7, -983.2, 30.8)}
		}
	},

	-- To locker room & roof
	{
		objHash = GetHashKey('v_ilev_ph_gendoor004'),
		objHeading = 90.0,
		objCoords = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- Rooftop
	{
		objHash = GetHashKey('v_ilev_gtdoor02'),
		objHeading = 90.0,
		objCoords = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- Hallway to roof
	{
		objHash = GetHashKey('v_ilev_arm_secdoor'),
		objHeading = 90.0,
		objCoords = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- Armory
	{
		objHash = GetHashKey('v_ilev_arm_secdoor'),
		objHeading = 270.0,
		objCoords = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- Captain Office
	{
		objHash = GetHashKey('v_ilev_ph_gendoor002'),
		objHeading = 180.0,
		objCoords = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('v_ilev_ph_gendoor005'), objHeading = 180.0, objCoords = vector3(443.9, -989.0, 30.6)},
			{objHash = GetHashKey('v_ilev_ph_gendoor005'), objHeading = 0.0, objCoords = vector3(445.3, -988.7, 30.6)}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 0.0,
		objCoords = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- Cell 1
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 270.0,
		objCoords = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- Cell 2
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 90.0,
		objCoords = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- Cell 3
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 90.0,
		objCoords = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- To Back
	{
		objHash = GetHashKey('v_ilev_gtdoor'),
		objHeading = 0.0,
		objCoords = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 0.0, objCoords  = vector3(467.3, -1014.4, 26.5)},
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 180.0, objCoords  = vector3(469.9, -1014.4, 26.5)}
		}
	},

	-- Back Gate
	{
		objHash = GetHashKey('hei_prop_station_gate'),
		objHeading = 90.0,
		objCoords = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objHash = GetHashKey('v_ilev_shrfdoor'),
		objHeading = 30.0,
		objCoords = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = {'police'},
		locked = false,
		maxDistance = 1.25
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = {'police'},
		locked = false,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_shrf2door'), objHeading = 315.0, objCoords  = vector3(-443.1, 6015.6, 31.7)},
			{objHash = GetHashKey('v_ilev_shrf2door'), objHeading = 135.0, objCoords  = vector3(-443.9, 6016.6, 31.7)}
		}
	},

	{
		textCoords = vector3(-441.97, 6011.79, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2,
		doors = {
			{objHash = GetHashKey('v_ilev_bk_door2'), objHeading = 45.0, objCoords  = vector3(-441.74, 6012.69, 31.7)},
			{objHash = GetHashKey('v_ilev_bk_door2'), objHeading = -135.0, objCoords  = vector3(-442.54, 6011.46, 31.7)}
		}
	},

	-- Entrance to hallway (double doors)
	{
		textCoords = vector3(-448.45, 6007.77, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2,
		doors = {
			{objHash = GetHashKey('v_ilev_ss_door8'), objHeading = -45.0, objCoords  = vector3(-447.73, 6007.57, 31.7)},
            {objHash = GetHashKey('v_ilev_ss_door7'), objHeading = 135.0, objCoords  = vector3(-448.24, 6007.42, 31.7)}
		}
	},

	-- Interogate room
	{
		objHash = GetHashKey('v_ilev_rc_door2'),
		objHeading = 135.0,
		objCoords  = vector3(-450.34, 6016.7, 31.72),
		textCoords = vector3(-450.56, 6016.15, 32.0),
		authorizedJobs = {'police'},
		maxDistance = 1.5,
		locked = true
	},

	-- Secure Interogate room
	{
		objHash = GetHashKey('v_ilev_cd_entrydoor'),
		objHeading = 370.0,
		objCoords  = vector3(-453.56, 6011.38, 32.0),
		textCoords = vector3(-453.56, 6011.38, 32.0),
		authorizedJobs = {'police'},
		maxDistance = 1.5,
		locked = true
	},

	-- Back hallway door
	{
		objHash = GetHashKey('v_ilev_gc_door01'),
		objHeading = -45.0,
		objCoords  = vector3(-451.36, 6007.8, 32.0),
		textCoords = vector3(-451.72, 6006.33, 32.0),
		authorizedJobs = {'police'},
		maxDistance = 1.5,
		locked = true
	},

	-- Back hallway door
	{
		objHash = GetHashKey ('v_ilev_gc_door01'),
		objHeading = 135.0,
		objCoords  = vector3(-446.53, 6001.8, 32.0),
		textCoords = vector3(-446.53, 6001.8, 32.0),
		authorizedJobs = {'police'},
		maxDistance = 1.5,
		locked = true
	},

	-- Side Gate
	{
		objHash = GetHashKey ('prop_fnclink_03gate5'),
		objHeading = -45.0,
		objCoords  = vector3(-450.5025, 6025.146, 32.11588),
		textCoords = vector3(-449.9, 6024.34, 32.6),
		authorizedJobs = {'police'},
		maxDistance = 1.25,
		locked = true
	},

	-- Armory Gate
	{
		objHash = GetHashKey ('v_ilev_fingate'),
		objHeading = -45.0,
		objCoords  = vector3(-436.65, 5992.04, 31.7),
		textCoords = vector3(-436.65, 5992.04, 32.0),
		authorizedJobs = {'police'},
		maxDistance = 2,
		locked = true
	},

	-- cell1
	{
		objHash = GetHashKey ('v_ilev_ph_cellgate'),
		objHeading = -45.0,
		objCoords  = vector3(-428.79, 5997.28, 31.72),
		textCoords = vector3(-428.79, 5997.28, 32.0),
		authorizedJobs = {'police'},
		maxDistance = 2,
		locked = true
	},

	-- cell1
	{
		objHash = GetHashKey ('v_ilev_ph_cellgate'),
		objHeading = -45.0,
		objCoords  = vector3(-432.01, 6000.42, 31.72),
		textCoords = vector3(-431.94, 6000.45, 32.0),
		authorizedJobs = {'police'},
		maxDistance = 2,
		locked = true
	},

	-- cell1
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = -45.0,
		objCoords  = vector3(-432.97, 5992.77, 31.72),
		textCoords = vector3(-432.97, 5992.77, 32.0),
		authorizedJobs = {'police'},
		maxDistance = 2,
		locked = true
	},

	-- gate1
	{
		objHash = GetHashKey('prop_gate_airport_01'),
		objHeading = 135.0,
		objCoords  = vector3(-456.87, 6030.8, 31.49),
		textCoords = vector3(-453.82, 6028.62, 32.42),
		authorizedJobs = {'police'},
		maxDistance = 15.0,
		locked = true
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objHash = GetHashKey('prop_gate_prison_01'),
		objCoords = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 12,
		size = 2
	},

	{
		objHash = GetHashKey('prop_gate_prison_01'),
		objCoords = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 12,
		size = 2
	}
}