Config = {}

Config.Animations = {

	{
		name  = 'festives',
		label = 'Festival',
		items = {
			{label = "Merokok", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING"}},
			{label = "Merokok Weed", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
			{label = "Bermain Musik", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
			{label = "Dj", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
			{label = "Minum", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
			{label = "PARTY : Minum Bir", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
			{label = "Air Guitar", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
			{label = "Air Shagging", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
			{label = "Mabuk", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
			-- {label = "Muntah di mobil", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside"}},
		}
	},

	{
		name  = 'greetings',
		label = 'Sapaan',
		items = {
			{label = "Menyapa", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
			{label = "Berjabat tangan", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
			{label = "Bersapa Groove", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
			{label = "Salut bandit", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
			{label = "Hormat", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}},
		}
	},

	{
		name  = 'work',
		label = 'Pekerjaan',
		items = {
			{label = "Menyerah", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_c"}},
			{label = "Mancing", type = "scenario", data = {anim = "world_human_stand_fishing"}},
			{label = "Polisi : Investigasi", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			{label = "Polisi : Berbicara di radio", type = "anim", data = {lib = "random@arrests", anim = "generic_radio_chatter"}},
			{label = "Polisi : Mengatur jalan", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
			{label = "Polisi : Meneropong", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
			{label = "Menanam", type = "scenario", data = {anim = "world_human_gardener_plant"}},
			{label = "Memperbaiki mesin", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped"}},
			{label = "Memperbaiki kolong kendaraan", type = "anim", data = {lib = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"}},
			-- {label = "Dokter : Obeservasi", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
			-- {label = "Taxi : parler au client", type = "anim", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle"}},
			{label = "Taxi : Memberikan tagihan", type = "scenario", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger"}},
			-- {label = "Membawa Belanjaan", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"}},
			-- {label = "Barman : servir un shot", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
			{label = "Memotret", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
			{label = "Transaksi: Melihat Catatan", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
			{label = "Memalu Paku", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
			-- {label = "Clochard : Faire la manche", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
			{label = "Mannequin Chalenge", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
		}
	},

	{
		name  = 'humors',
		label = 'Ekspresi',
		items = {
			{label = "Tepuk Tangan", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "Super", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06"}},
			{label = "Menunjuk", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
			{label = "Come", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}}, 
			{label = "Bring it on", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
			{label = "Saya ?", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
			{label = "I knew it, Damn", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
			-- {label = "Etre épuisé", type = "scenario", data = {lib = "amb@world_human_jog_standing@male@idle_b", anim = "idle_d"}},
			-- {label = "Je suis dans la merde", type = "scenario", data = {lib = "amb@world_human_bum_standing@depressed@idle_a", anim = "idle_a"}},
			{label = "Facepalm", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
			{label = "Keep calm ", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
			{label = "Apa yg saya lakukan ?", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "Takut", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
			{label = "Fight ?", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
			{label = "It's not possible", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
			{label = "Berpelukan", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
			{label = "Fuck u", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
			{label = "Wanker", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
			{label = "Bullet in the head", type = "anim", data = {lib = "mp_suicide", anim = "pistol"}},
		}
	},

	{
		name  = 'sports',
		label = 'Olah Raga',
		items = {
			{label = "Binarawagan", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
			{label = "Barbel", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
			{label = "Push up", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base"}},
			{label = "Sit Up", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base"}},
			{label = "Yoga", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
		}
	},

	{
		name  = 'misc',
		label = 'Sehari-hari',
		items = {
			{label = "Minum coffee", type = "anim", data = {lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a"}},
			{label = "Duduk", type = "anim", data = {lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle"}},
			{label = "Menunggu bersandar di dinding", type = "scenario", data = {anim = "world_human_leaning"}},
			{label = "Rebahan", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "Tengkurap", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
			{label = "Cleaning", type = "scenario", data = {anim = "world_human_maid_clean"}},
			{label = "Memasak", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
			{label = "Search Position", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female"}},
			{label = "Selfie", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
			{label = "Listening at a door", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}}, 
		}
	},

	{
		name  = 'attitudem',
		label = 'Perilaku',
		items = {
			{label = "Normal (Pria)", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
			{label = "Normal (Wanita)", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
			{label = "Depresi (Pria)", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
			{label = "Depresi (Wanita)", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
			{label = "Bisnis", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
			{label = "Determine", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
			{label = "Kasual", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
			{label = "Ate too much", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
			{label = "Hipster", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
			{label = "Terluka", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
			{label = "Intimidasi", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
			{label = "Hobo", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
			{label = "Unfortunate", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
			{label = "Muscle", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
			{label = "Shock", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
			{label = "Dark", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
			{label = "Fatigue", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
			{label = "Hurry", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
			{label = "Fier", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
			{label = "Small race", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
			{label = "Man Eater", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
			{label = "Sassy", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},	
			{label = "Arogan", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
		}
	},
	{
		name  = 'porn',
		label = 'PEGI-21',
		items = {
			{label = "Man getting fucked *** in car", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop"}},
			{label = "Woman making a treat in car", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop"}},
			{label = "Man fucked ** in car", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player"}},
			{label = "Woman fucked ** in car", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female"}},
			{label = "Scratching your balls", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch"}},
			{label = "Charming", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
			{label = "Prostitute Pose", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
			{label = "Show chest", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
			{label = "Strip Tease 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
			{label = "Strip Tease 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
			{label = "Stip Tease on the ground", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
		}
	}
}