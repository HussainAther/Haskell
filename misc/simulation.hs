doSimulation servSt (im:messes)
  = outmesses ++ doSimulation servStNext messes
  where
  (servStNewxt , outmesses) = simulationStep sevSt im
