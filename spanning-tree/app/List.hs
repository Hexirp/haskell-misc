module List (processEdgeList) where

processEdgeList :: String -> [(String, String)] -> [(String, String)]
processEdgeList rootNode edgeList = undefined

foo :: String -> [(String, String)] -> [(String, String)]
foo rootNode edgeList = filter (bar rootNode) edgeList

bar :: String -> (String, String) -> Bool
bar rootNode edge = rootNode == startNode edge

startNode :: (String, String) -> String
startNode (start_node, _) = start_node

endNode :: (String, String) -> String
endNode (_, end_node) = endNode
