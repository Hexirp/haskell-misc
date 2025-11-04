module Main (main) where

import Data.Text.IO.Utf8 as Text (putStr)
import Data.Text.Lazy as LazyText (toStrict)
import Data.Text.Lazy.Builder as LazyTextBuilder (Builder, fromString, toLazyText)
import Data.Text.Lazy.Builder.Int as LazyTextBuilder (decimal)
import System.Environment (getArgs)
import Text.Read (readMaybe)

permalink :: Word -> LazyTextBuilder.Builder
permalink oldid =
  if oldid >= 1
    then LazyTextBuilder.fromString "Special:Permalink/" <> LazyTextBuilder.decimal oldid
    else error "permalink: non-positive oldid"

link :: LazyTextBuilder.Builder -> LazyTextBuilder.Builder
link name = LazyTextBuilder.fromString "[[" <> name <> LazyTextBuilder.fromString "]]"

list :: [LazyTextBuilder.Builder] -> LazyTextBuilder.Builder
list = foldMap (\text -> LazyTextBuilder.fromString "# " <> text <> LazyTextBuilder.fromString "\n")

permalink1000 :: Word -> LazyTextBuilder.Builder
permalink1000 oldid = list $ map (link . permalink) $ take 1000 [oldid ..]

main :: IO ()
main = do
  args <- getArgs
  case args of
    [arg1] -> case readMaybe arg1 of
      Nothing -> error "Usage: mediawiki-gen <oldid>"
      Just oldid -> if oldid >= 1
        then Text.putStr $ LazyText.toStrict $ LazyTextBuilder.toLazyText $ permalink1000 oldid
        else error "Usage: mediawiki-gen <oldid>"
    _ -> error "Usage: mediawiki-gen <oldid>"
