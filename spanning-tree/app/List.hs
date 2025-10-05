module List (processEdgeList) where

import Data.Map as Map (Map, insertWith, empty, singleton, findWithDefault, insert)
import Data.Sequence as Seq (Seq (Empty, (:<|)), singleton, (|>))
import Data.Set as Set (Set, singleton, notMember, insert)

processEdgeList :: String -> [(String, String)] -> [(String, String)]
processEdgeList rootNode edgeList =
  concatMap extractShortestPathEdgeList $ bfsShortestPathEdgeListMap rootNode $ buildAdjacencyMap edgeList

buildAdjacencyMap :: [(String, String)] -> Map.Map String [String]
buildAdjacencyMap = foldr (\(start_node, end_node) -> Map.insertWith (++) start_node [end_node]) Map.empty

bfsShortestPathEdgeListMap :: String -> Map String [String] -> Map.Map String [String]
bfsShortestPathEdgeListMap rootNode graphMap =
  bfsShortestPathEdgeListMap_ graphMap (Set.singleton rootNode) (Seq.singleton rootNode) (Map.singleton rootNode [])

bfsShortestPathEdgeListMap_ :: Map.Map String [String] -> Set.Set String -> Seq.Seq String -> Map.Map String [String] -> Map.Map String [String]
bfsShortestPathEdgeListMap_ graph_map visited_node_set focused_node_queue shortest_path_edge_list_map =
  case focused_node_queue of
    Empty -> shortest_path_edge_list_map
    current_focused_node :<| rest_focused_node_queue ->
      let
        neighbor_node_list = Map.findWithDefault [] current_focused_node graph_map
        new_neighbor_node_list = filter (`Set.notMember` visited_node_set) neighbor_node_list
        new_visited_node_set = foldr Set.insert visited_node_set new_neighbor_node_list
        new_focused_node_queue = foldl (|>) rest_focused_node_queue new_neighbor_node_list
        new_shortest_path_edge_list_map = foldl (\new_map new_node -> Map.insert new_node (current_focused_node : Map.findWithDefault [] current_focused_node new_map) new_map) shortest_path_edge_list_map new_neighbor_node_list
      in
        bfsShortestPathEdgeListMap_ graph_map new_visited_node_set new_focused_node_queue new_shortest_path_edge_list_map

extractShortestPathEdgeList :: [String] -> [(String, String)] 
extractShortestPathEdgeList shortestPathEdgeList =
  zip (reverse shortestPathEdgeList) (drop 1 $ reverse shortestPathEdgeList)
