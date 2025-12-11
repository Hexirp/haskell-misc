{-# LANGUAGE OverloadedStrings  #-}

module Main (main) where

import Data.Text.IO.Utf8 as Text (putStr)
import Data.Text.Lazy as LazyText (toStrict)
import Data.Text.Lazy.Builder as LazyTextBuilder (Builder, toLazyText)
import Data.Text.Lazy.Builder.Int as LazyTextBuilder (decimal)
import System.Environment (getArgs)
import Text.Read (readMaybe)

diff :: Word -> LazyTextBuilder.Builder
diff oldid =
  if oldid >= 1
    then "Special:Diff/" <> LazyTextBuilder.decimal oldid
    else error "diff: non-positive oldid"

link :: LazyTextBuilder.Builder -> LazyTextBuilder.Builder
link name = "[[" <> name <> "]]"

list :: [LazyTextBuilder.Builder] -> LazyTextBuilder.Builder
list = foldMap (\text -> "# " <> text <> "\n")

diff1000 :: Word -> LazyTextBuilder.Builder
diff1000 oldid = list $ map (link . diff) $ take 1000 [oldid ..]

main :: IO ()
main = do
  args <- getArgs
  case args of
    [arg1] -> case readMaybe arg1 of
      Nothing -> error "Usage: mediawiki-gen <oldid>"
      Just oldid -> if oldid >= 1
        then Text.putStr $ LazyText.toStrict $ LazyTextBuilder.toLazyText $ diff1000 oldid
        else error "Usage: mediawiki-gen <oldid>"
    _ -> error "Usage: mediawiki-gen <oldid>"
