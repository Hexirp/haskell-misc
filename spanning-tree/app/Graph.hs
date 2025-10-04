{-# LANGUAGE OverloadedStrings #-}

module Graph (processDotText) where

import Data.Foldable (Foldable (toList), forM_)
import Data.GraphViz (GraphID (Str), parseDotGraph)
import Data.GraphViz.Printing (PrintDot (toDot), renderDot)
import Data.GraphViz.Types.Generalised as GraphViz (DotEdge (DotEdge), DotGraph (graphStatements), DotStatement (DE))
import Data.GraphViz.Types.Monadic (digraph, edge)
import Data.Maybe (mapMaybe)
import Data.Text.Lazy as LazyText (Text)
import List (processEdgeList)

processDotText :: String -> LazyText.Text -> LazyText.Text
processDotText rootNodeName dotText =
  renderDotGraph $ processDotGraph rootNodeName $ parseDotGraph dotText

processDotGraph :: String -> GraphViz.DotGraph String -> GraphViz.DotGraph String
processDotGraph rootNodeName dotGraph =
  buildDotGraph $ processEdgeList rootNodeName $ extractEdgeList dotGraph

extractEdgeList :: GraphViz.DotGraph String -> [(String, String)]
extractEdgeList dotGraph = mapMaybe extractEdge $ toList $ GraphViz.graphStatements dotGraph

extractEdge :: DotStatement String -> Maybe (String, String)
extractEdge (DE (DotEdge start_node end_node _)) = Just (start_node, end_node)
extractEdge _ = Nothing

buildDotGraph :: [(String, String)] -> GraphViz.DotGraph String
buildDotGraph edgeList = digraph (Str "spanning_tree") $ do
  forM_ edgeList $ \(start_node, end_node) -> edge start_node end_node []

renderDotGraph :: GraphViz.DotGraph String -> LazyText.Text
renderDotGraph = renderDot . toDot
