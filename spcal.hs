import Graphics.UI.Gtk
import System.IO
import MySpinBox
import Round
import Control.Monad
readSample :: IO [Double]
readSample = do
    r <- getContents
    return $ map read $ lines r
rad d = ((2*pi)/360)*d
dig r = r / (yen/360)
yen = rad 360 :: Double 
hosei = 2.4 / 2 :: Double
calLen a b d k h = sqrt ((a^2+b^2+d^2) - (2*a*b*(cos $ alfa h k))) - hosei
    where alfa h k = rad (360 / h * k)
disp h a b c s = do
    print $ s++"-side"
    let l = map (\x -> calLen (a/2) (b/2) c x h) [0,2..8]
    zipWithM (\x y -> do 
                    putStr $ show x
                    putStr "cross="
                    putStr $ show $ round1 y
                    putStrLn "mm")
        ([0..4]::[Int])
        l
    print () 
main = do
    a:b:c:d:e:[] <- readSample
    print $ a:b:c:d:e:[] 
    initGUI
    window  <- windowNew
    hbox <- hBoxNew False 0
    vbox <- vBoxNew False 0
    boxPackStart vbox hbox PackNatural 0
    let names = ["スポーク穴数",
                    "erd(mm)",
                    "pcd(mm)",
                    "flange2center(mm)",
                    "pcd(mm)",
                    "flange2center(mm)"]
    adjs <- mkAdjustments [(32, 20, 40 ,4,4),
                            (a,200, 700, 0.1,10),
                            (b,30, 100 ,1,1),
                            (c,10, 50, 0.1,1),
                            (d,30, 100 ,1,1),
                            (e,10, 50, 0.1,1)]
    spins@s0:s1:s2:s3:s4:s5 <- myAddSpinButtons hbox names adjs
    mapM_ ( `set` [spinButtonDigits := 0]) [s0,s2,s4]

    update adjs
    mapM (\x-> onValueChanged x (update adjs)) adjs
    containerAdd window vbox
    widgetShowAll window
    window `on` unrealize $ end adjs
    mainGUI
end adjs = do
    l <- mapM (`get` adjustmentValue) adjs
    mapM_ (\x -> hPutStrLn stderr $ show x) $ tail l
    mainQuit
update adjs = do
    h:a:b:c:d:e:_ <- mapM (`get` adjustmentValue) adjs
    disp h a b c "left"
    disp h a d e "right"
