module Main where

import Control.Applicative
import Control.Exception
import Control.Monad (when, replicateM)
import Network.Socket hiding (send)
import Network.Socket.ByteString
import qualified Data.ByteString.Char8 as B8

toSend :: Int
toSend = 10 * 1000 * 10000

main = withSocketsDo $ do
  print toSend
  let b = B8.replicate 64 'Q'
  addrInfo <- head <$> getAddrInfo Nothing (Just "127.0.0.1") (Just "9999")
  s <- socket (addrFamily addrInfo) Datagram defaultProtocol
  connect s (addrAddress addrInfo)
  let loop = send s b >>= \i -> do when (i==0)  $ throwIO (ErrorCall "fck")
                                   when (i/=64) loop
  replicateM toSend $ loop
