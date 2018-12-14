module ShowButton where
import MySpinBox
import Graphics.UI.Gtk
import Control.Monad

mkShowButton :: HBox -> String -> Double -> IO SpinButton
mkShowButton h n v = do 
    adj <- mkAdjustment (v,v,v,0,0)
    myAddSpinButton h n adj
mkShowButtons :: HBox -> [(String, Double)] -> IO [SpinButton]
mkShowButtons h = mapM (\(a,b) -> mkShowButton h a b)

setItem:: HBox -> Int -> [(String, Double)] -> [String] -> IO Button
setItem h i list name = do
    b <- buttonNewWithLabel (show i)
    containerAdd h b
    sbs <- mkShowButtons h list
    let lb = foldl (\x y -> x ++ " " ++ y) "" name
    --l <- labelNew $ Just lb
    l <- labelNewWithMnemonic lb
    miscSetAlignment l 0.0 0.0
    l `set` [labelWidthChars := 50]
    containerAdd h l
    return b
--setItems :: HBox -> [(String, Double)] -> [String] -> IO ()
--setItems h list name = do
