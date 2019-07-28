--Loop through chunks of a file and accumulate lines. The enumerator feeds data to an
--iteratee to get a result.

enumerateFile path initIter = 
  withFile path Readmode $ \h
    let 
    go iter = do
      isEOF <- HIsEOF h
      if isEOF
        then return (HaveLine "End of File" "")
        else do
          chunk <- B.hGet h 8
          check $
      runIter iter chunk check (NeedChunk iterNext) = 
              iterNext check (HaveLine residual) = do putStrLn line check $ runIter initIter in go initIter
      
