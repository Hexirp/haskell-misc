module Main (main) where

import Data.Text.Lazy.IO as LazyText (putStrLn, readFile)
import Graph (processDotText)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [fileName, rootNodeName] -> main2 fileName rootNodeName
    _ -> Prelude.putStrLn "Usage: spanning-tree-exe <dot_file> <root_node>"

main2 :: String -> String -> IO ()
main2 fileName rootNodeName = do
  dotText <- LazyText.readFile fileName
  LazyText.putStrLn $ processDotText rootNodeName dotText
