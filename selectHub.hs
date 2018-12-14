import ShowButton 
import Control.Monad
import Graphics.UI.Gtk
main = do
    c <- getContents
    let l = lines c
    let w = map words l 
    let rs = [(take 4 x,drop 4 x)|x <- w]
    initGUI
    window  <- windowNew
    window `set` [windowDefaultWidth := 700, 
                    windowDefaultHeight := 500,
                    windowTitle := "To select an item, click number."]
    sw <- scrolledWindowNew Nothing Nothing
    hbox <- hBoxNew False 0
    vbox <- vBoxNew False 0
    boxPackStart vbox hbox PackNatural 0
    let (a,b) = head rs
    bs <- zipWithM (\(a,b) y -> setf vbox y a b) rs ([0..length rs - 1])
    mapM_ (\x -> (x `on` buttonActivated) (buttonOn x rs)) bs
    scrolledWindowAddWithViewport sw vbox
    containerAdd window sw
    widgetShowAll window
    window `on` unrealize $ mainQuit
    mainGUI
buttonOn b rs = do
    bl <- b `get` buttonLabel
    let i = read bl::Int
    let (a,b) = rs !! i
    mapM_ (\x -> do {putStr x; putStr " ";}) a
    putStrLn ""
    mainQuit
setf box i (a:b:c:d:[]) name = do
    hbox <- hBoxNew False 0
    btn <- setItem hbox i 
        [("pcd(mm)",read a), 
        ("f2c(mm)",read b), 
        ("pcd(mm)",read c), 
        ("f2c(mm)",read d)] 
        name
    boxPackStart box hbox PackNatural 0
    return btn
