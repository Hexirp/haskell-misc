module Graph (processDotText) where

import Data.Text.Lazy as LazyText (Text, unpack)

import Data.GraphViz as GraphViz
import Data.GraphViz.Printing as GraphViz (DotCode, renderDot, toDot)

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
