-- Copy input to output

copyInputToOutput : : I0 ( ) copyInputToOutput
  = while (do res <- isEOF 
    return (not res))
  (do line <- getLine 
    putStrLn line)
