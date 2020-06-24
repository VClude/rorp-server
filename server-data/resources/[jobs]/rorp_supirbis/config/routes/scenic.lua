ScenicRoute = {
    Name = 'scenic_route',
    Bus = BusType.CityBus,
    SpawnPoint = {x = 244.29, y = 1152.79, z = 225.46, heading = 11.79},
    BusReturnPoint = {x = 244.29, y = 1152.79, z = 225.46, heading = 11.79},
    Payment = 15000,
    PaymentPerStation = Payment / 5,
    Lines = {
        {
            Name = 'scenic_route',
            BusColor = 39,
            Stops = {
                {x = -1889.26,   y = 2045.91, z = 140.21, name = 'stop_petani', unloadType = UnloadType.All},
                {x = -1085.12, y = -2011.23,  z = 12.37, name = 'stop_tukang_sapi', unloadType = UnloadType.Some},
                {x = 915.2, y = -2194.81, z = 29.66, name = 'stop_miner', unloadType = UnloadType.Some},
                {x = 1257.96, y = -1271.65, z = 34.61, name = 'stop_lumberjack', unloadType = UnloadType.Some},
                {x = 795.19, y = -958.41, z = 25.17, name = 'stop_tailor', unloadType = UnloadType.Some},
                -- {x = -329.8910,  y = 6185.0571, z = 31.6218, name = 'stop_paleto_bay', unloadType = UnloadType.Some},
                -- {x = 1660.6237,  y = 4857.0190, z = 41.2123, name = 'stop_grapeseed', unloadType = UnloadType.Some},
                -- {x = 1962.9892,  y = 3710.2802, z = 32.2184, name = 'stop_sandy_shores', unloadType = UnloadType.Some},
                -- {x = 2237.2424,  y = 3190.7673, z = 48.7102, name = 'stop_senora_park', unloadType = UnloadType.Some},
                -- {x = 549.9940,   y = 2700.2866, z = 42.1508, name = 'stop_harmony', unloadType = UnloadType.Some},
                -- {x = 424.7632,   y = -638.9176, z = 28.5001, name = 'stop_dashound', unloadType = UnloadType.All},
            }
        }
    }
}
