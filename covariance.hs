import Math.Statistics

--Obtain covariance matrix from samples.

main = do pring $ covMatrix matrixArray
  where matrixArray = [[1, 1, 0, 0]
                      ,[0, 1, 0, 1]
                      ,[1, 1, 0, 1]]
