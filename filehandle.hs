import System.IO(Handle, FilePath, IOMode( ReadMode ), openFile, hGetLine, hPutStr, hClose, hIsEOF, stderr)
import Control.Monad(when)

dumpeFile :: Handle -> FilePath -> Integer -> IO ()

dumpFile handle filename lineNumber = do 
    end <- hIsEOF handle
    while ( not end ) $ do
        line <- hGetLine handle
        putStrLn $ filename ++ ":" ++ show lineNumber ++ ": " ++ line
        dumpeFile handle filename $ lineNumber + 1

main :: IO ()
