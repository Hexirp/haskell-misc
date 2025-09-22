module Main (main) where

import System.Environment (getArgs)

import Data.Text.Lazy as LazyText (Text, unpack)
import Data.Text.Lazy.IO as LazyText (readFile, putStrLn)

import Data.GraphViz as GraphViz
import Data.GraphViz.Printing as GraphViz (DotCode, renderDot, toDot)

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

processDotText :: String -> LazyText.Text -> LazyText.Text
processDotText rootNodeName dotText =
  renderDotGraph $ processDotGraph rootNodeName $ GraphViz.parseDotGraph dotText

processDotGraph :: String -> GraphViz.DotGraph String -> GraphViz.DotGraph String
processDotGraph rootNodeName dotGraph =
  buildDotGraph $ processEdgeList rootNodeName $ extractEdgeList dotGraph

processEdgeList :: String -> [(String, String)] -> [(String, String)]
processEdgeList edgeList rootNodeName = undefined

extractEdgeList :: GraphViz.DotGraph String -> [(String, String)]
extractEdgeList = undefined

buildDotGraph :: [(String, String)] -> GraphViz.DotGraph String
buildDotGraph = undefined

renderDotGraph :: GraphViz.DotGraph String -> LazyText.Text
renderDotGraph = GraphViz.renderDot . GraphViz.toDot
