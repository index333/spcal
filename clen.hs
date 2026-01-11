import Data.Complex
yen = 2*pi ; p = 12.7
dist :: (Complex Double, Complex Double) -> Double
dist (a,b) = magnitude (a-b)
dist' = return . dist
f :: (Double,Double) -> Double -> IO Double
f (h,l) t = do
    if abs(h - l) < 0.1 
    then return h  
    else    do  m <-  mid' (h,l)
                b <- 
                    c m t >>= return . (> p)
                if b    then f (m ,l) t 
                        else f (h, m) t
mid :: (Double,Double) -> Double
mid(h,l) = (h+l) / 2
mid' = return . mid 
c x t = dist' (a,b)
    where   a = mkPolar x (yen / t)
            b = mkPolar x 0
f2 :: (Double,Double) -> Double -> Double -> IO (Double, Double)
f2 (h,l) hyp op = do
    if abs(h - l) < 0.00001 
    then do (i,com) <- c2' (h, hyp)
            return (h,realPart com)
    else    do  m <- mid' (h,l)
                b <- 
                    c2' (m, hyp) >>= \(i,_) -> return (i > op)
                if b    then f2 (m , l) hyp op
                        else f2 (h, m) hyp op
c2 :: Double -> Double -> (Double, Complex Double)
c2 x mag = (imagPart a,a) where a = mkPolar mag x
c2' = return . (uncurry c2)
main = do
    let [ft,rt,h,l] = [48,16,200,0]
    fpcr <- f (h,l) ft 
    rpcr <- f (h,l) rt 
    print fpcr
    print rpcr
    let [hyp,op,h,l] = [405,(fpcr-rpcr),yen/4,0]
    (a,b) <- f2 (h,l) hyp op
    print (a,b)
    let l0 = ft * (yen / 4 + a) / yen
    let l1 = rt * (yen / 4 - a) / yen
    let l2 = b / p
    print $ (l0 + l1 + l2) * 2
