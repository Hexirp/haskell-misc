import SpanningTree (processEdgeList)
import Test.Hspec (describe, hspec, it, shouldBe)

main :: IO ()
main = hspec $ do
  describe "SpanningTree.processEdgeList" $ do
    it "is fine" $ do
      processEdgeList "0" [("0", "1"), ("1", "2"), ("2", "3"), ("3", "2"), ("2", "4"), ("3", "4")] `shouldBe` [("0", "1"), ("1", "2"), ("2", "3"), ("2", "4")]
