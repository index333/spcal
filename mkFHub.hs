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
    let names = ["pcd(mm)", "エンドフランジ距離"]
    adjs <- mkAdjustments [(40,30, 100, 1,10), (30,30,50,1,10)]
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
    v0:v1:[] <- mapM (`get` adjustmentValue) adjs
    let h = 100 / 2
    hPutStr stderr $ "2.6"
    hPutStr stderr " " 
    hPutStr stderr $ show v0
    hPutStr stderr " " 
    hPutStr stderr $ show $ h - v1
    hPutStr stderr " " 
    hPutStr stderr $ show v0
    hPutStr stderr " " 
    hPutStr stderr " " 
    hPutStr stderr $ show $ h - v1
    hPutStr stderr " " 
    e' <- e `get` entryText
    hPutStrLn stderr e'
    mainQuit
