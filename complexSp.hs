import Data.Complex
yen = pi * 2
hosei = 2.4 / 2 :: Double
dist :: Complex Double -> Complex Double -> Double
dist a b = magnitude (a-b)
fa pcd h k = mkPolar r ph
    where   r = pcd / 2
            d = yen / (h / 2)  
            ph = d * (k-1) / 2
fb erd h = mkPolar r ph
    where   r = erd / 2 
            ph = yen / h * (-1)
f2fc ew e2f = dist' (c1, c2)
    where   r1 = e2f
            r2 = ew / 2
            [c1,c2] = map (:+ 0) [r1,r2]
hypo x y = dist' (a, b)
    where   a = 0
            b = x :+ y
main = do
    a <- fa' (38, 32, 6)
    b <- fb' (552, 32) 
    l <- dist' (a,b)
    print l
    f2fc 100 16 >>= hypo l >>= hosei' >>= print
dist' = return . (uncurry dist) 
fa' = return . (uncurry3 fa) 
fb' = return . (uncurry fb)
hosei' x = return (x - hosei)
uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (a, b, c) = f a b c
