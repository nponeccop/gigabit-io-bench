module Main where

import Control.Applicative
import Control.Exception
import Control.Monad (when, replicateM_)
import Network.Socket hiding (sendTo, send)
import Network.Socket.ByteString
import qualified Data.ByteString.Char8 as B8

toSend :: Int
toSend = 10 * 1000 * 1000

b :: B8.ByteString
b = B8.replicate 64 'Q'

main = withSocketsDo $ do
  print toSend
  addrInfo <- head <$> getAddrInfo (Just defaultHints{addrSocketType=Datagram}) (Just "127.0.0.1") (Just "9999")
  s <- socket (addrFamily addrInfo) Datagram defaultProtocol
  let a = addrAddress addrInfo
  let loop = sendTo s b a >>= \i -> when (i==0)  $ throwIO (ErrorCall "fck")
  replicateM_ toSend loop
