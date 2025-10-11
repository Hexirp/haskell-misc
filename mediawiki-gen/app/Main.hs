module Main (main) where

import System.Environment (getArgs)
import Text.Read (readMaybe)

permalink :: Word -> String
permalink oldid =
  if oldid >= 1
    then "Special:Permalink/" ++ show oldid
    else error "Usage: mediawiki-gen-exe <oldid>"

link :: String -> String
link name = "[[" ++ name ++ "]]"

list :: [String] -> String
list = concatMap (\text -> "# " ++ text ++ "\n")

permalink100 :: Word -> String
permalink100 oldid = list $ map (link . permalink) $ take 100 [oldid ..]

main :: IO ()
main = do
  args <- getArgs
  case args of
    [arg1] -> case readMaybe arg1 of
      Nothing -> error "Usage: mediawiki-gen-exe <oldid>"
      Just oldid -> putStrLn $ permalink100 oldid
    _ -> error "Usage: mediawiki-gen-exe <oldid>"
