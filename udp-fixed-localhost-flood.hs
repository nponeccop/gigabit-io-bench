module Main where

import Control.Applicative
import Control.Exception
import Control.Monad (when, replicateM)
import Network.Socket hiding (sendTo, send)
import Network.Socket.ByteString
import qualified Data.ByteString.Char8 as B8

toSend :: Int
toSend = 10 * 1000 * 10000

main = withSocketsDo $ do
  print toSend
  let b = B8.replicate 64 'Q'
  addrInfo <- head <$> getAddrInfo (Just defaultHints{addrSocketType=Datagram}) (Just "127.0.0.1") (Just "9999")
  s <- socket (addrFamily addrInfo) Datagram defaultProtocol
  let a = addrAddress addrInfo
  let loop = sendTo s b a >>= \i -> do
                when (i==0)  $ throwIO (ErrorCall "fck")
                when (i/=64) loop
  replicateM toSend $ loop
