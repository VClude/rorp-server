AirportRoute = {
    Name = 'airport_route',
    Bus = BusType.Shuttle,
    SpawnPoint = {x = -923.7001, y = -2283.8886, z = 6.7090, heading = 333.65},
    BusReturnPoint = {x = -923.7001, y = -2283.8886, z = 6.7090, heading = 333.65},
    Payment = 8000,
    PaymentPerStation = 1000,
    Lines = {
        {
            Name = 'airport_route',
            BusColor = 5,
            Stops = {
                {x = -1034.18, y = -2729.91, z = 20.08, name = 'stop_airport', unloadType = UnloadType.None},
                {x = 309.62, y = -1377.16,  z = 31.81, name = 'stop_driving_school', unloadType = UnloadType.None},
                {x = 276.82, y = -580.35, z = 42.89, name = 'stop_rumah_sakit', unloadType = UnloadType.All},
                {x = -392.49, y = 1202.8,  z = 325.64, name = 'stop_job_center', unloadType = UnloadType.Some},
                {x = 224.14, y = 1240.34, z = 225.22,  name = 'stop_transit_bus', unloadType = UnloadType.Some},
                {x = 251.56, y = -574.26, z = 42.96, name = 'stop_penris', unloadType = UnloadType.All},
                {x = 253.01,  y = -1502.8, z = 28.9,  name = 'stop_ZANY', unloadType = UnloadType.Some},
                {x = -1034.18,  y = -2729.91, z = 20.08,  name = 'stop_airport', unloadType = UnloadType.Some},
            }
        }
    }
}
