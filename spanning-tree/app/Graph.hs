{-# LANGUAGE OverloadedStrings #-}

module Graph (processDotText) where

import Data.Maybe (mapMaybe)

import Data.Foldable (Foldable (toList), forM_)

import Data.Text.Lazy as LazyText (Text)

import Data.GraphViz (parseDotGraph, GraphID (Str))
import Data.GraphViz.Printing (PrintDot (toDot), renderDot)
import Data.GraphViz.Types.Generalised as GraphViz (DotStatement (DE), DotGraph (graphStatements), DotEdge (DotEdge))
import Data.GraphViz.Types.Monadic (digraph, edge)

processDotText :: String -> LazyText.Text -> LazyText.Text
processDotText rootNodeName dotText =
  renderDotGraph $ processDotGraph rootNodeName $ parseDotGraph dotText

processDotGraph :: String -> GraphViz.DotGraph String -> GraphViz.DotGraph String
processDotGraph rootNodeName dotGraph =
  buildDotGraph $ processEdgeList rootNodeName $ extractEdgeList dotGraph

processEdgeList :: String -> [(String, String)] -> [(String, String)]
processEdgeList edgeList rootNodeName = undefined

extractEdgeList :: GraphViz.DotGraph String -> [(String, String)]
extractEdgeList dotGraph = mapMaybe extractEdge $ toList $ GraphViz.graphStatements dotGraph

extractEdge :: DotStatement String -> Maybe (String, String)
extractEdge (DE (DotEdge start_point end_point _)) = Just (start_point, end_point)
extractEdge _ = Nothing

buildDotGraph :: [(String, String)] -> GraphViz.DotGraph String
buildDotGraph edgeList = digraph (Str "spanning_tree") $ do
  forM_ edgeList $ \(start_point, end_point) -> edge start_point end_point []

renderDotGraph :: GraphViz.DotGraph String -> LazyText.Text
renderDotGraph = renderDot . toDot
