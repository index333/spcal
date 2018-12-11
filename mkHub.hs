import Graphics.UI.Gtk
import System.IO
import MySpinBox
import Round
import Control.Monad
main = do
    initGUI
    window  <- windowNew
    hbox <- hBoxNew False 0
    vbox <- vBoxNew False 0
    boxPackStart vbox hbox PackNatural 0
    let names = ["エンド幅(mm)",
                    "pcd(mm)",
                    "エンドフランジ距離(mm)",
                    "pcd(mm)",
                    "エンドフランジ距離"]
    adjs <- mkAdjustments [(100,100,135,1,10), 
                            (40,30, 100, 1,10), 
                            (30,30,50,1,10),
                            (30,30, 100, 1,10), 
                            (30,30,50,1,10)]
    spins <- myAddSpinButtons hbox names adjs
    mapM_ (`set` [spinButtonDigits := 0]) spins
    l <- labelNew $ Just "hub name"
    e <- entryNew
    e `on` entryActivate $ end adjs e
    containerAdd vbox l
    containerAdd vbox e

    containerAdd window vbox
    widgetShowAll window
    window `on` unrealize $ mainQuit
    mainGUI
end adjs e = do
    v0:v1:v2:v3:v4:[] <- mapM (`get` adjustmentValue) adjs
    let h = v0 / 2
    hPutStr stderr $ "2.6"
    hPutStr stderr " " 
    hPutStr stderr $ show v1
    hPutStr stderr " " 
    hPutStr stderr $ show $ h - v2
    hPutStr stderr " " 
    hPutStr stderr $ show v3
    hPutStr stderr " " 
    hPutStr stderr $ show $ h - v4
    hPutStr stderr " " 
    e' <- e `get` entryText
    hPutStrLn stderr e'
    mainQuit
