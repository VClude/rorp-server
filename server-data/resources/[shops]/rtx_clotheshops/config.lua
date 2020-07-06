Config = {}

Config.Locale = 'en'

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 2.5, y = 2.5, z = 1.0}
Config.MarkerColor  = {r = 255, g = 102, b = 255}
Config.MarkerType   = 27

Config.Zones = {}

Config.Shops = {
  {x=72.254,    y=-1399.102, z=28.406},
  {x=-703.776,  y=-152.258,  z=36.445},
  {x=-167.863,  y=-298.969,  z=38.763},
  {x=428.694,   y=-800.106,  z=28.521},
  {x=-829.413,  y=-1073.710, z=10.3528},
  {x=-1447.797, y=-242.461,  z=48.852},
  {x=11.632,    y=6514.224,  z=30.907},
  {x=123.646,   y=-219.440,  z=53.587},
  {x=1696.291,  y=4829.312,  z=41.093},
  {x=618.093,   y=2759.629,  z=41.118},
  {x=1190.550,  y=2713.441,  z=37.252},
  {x=-1193.429, y=-772.262,  z=16.354},
  {x=-3172.496, y=1048.133,  z=19.893},
  {x=-1108.441, y=2708.923,  z=18.137},
  {x=-935.17, y=-176.4, z=45.3},
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end

