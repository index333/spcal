import Data.Complex
import Control.Monad
import qualified Graphics.UI.Threepenny       as UI
import           Graphics.UI.Threepenny.Core
main = do
    startGUI defaultConfig
        { jsPort       = Just 8023
        , jsStatic     = Just "../wwwroot"
        } setup
toD :: String -> IO Float
toD = (return . read) 
mkSpinBox atr w = do
    let [min,max,step,val] = map show atr
    s <- UI.input   # set (attr "type") "number"
                    # set (attr "min") min
                    # set (attr "max") max
                    # set (attr "step") step 
                    # set (attr "value") val
    getBody w #+ [element s]
    return s
mkLabel s w = do 
    l <- UI.span # set UI.text s
    getBody w #+ [element l]
mkSpinboxWithTitle t vs w = do
    mkLabel t w
    mkSpinBox vs w
setup :: Window -> UI ()
setup w = do
    void $ return w # set UI.title "spoke length"
    sp0 <-mkSpinboxWithTitle "erd(mm)" [300,700,1,500] w
    sp1 <-mkSpinboxWithTitle "holes" [28,36,4,32] w
    sp2 <-mkSpinboxWithTitle "pcd(mm)" [20,80,1,40] w
    sp3 <-mkSpinboxWithTitle "flange width(mm)" [20,70,1,50] w
    sp4 <-mkSpinboxWithTitle "offset(mm)" [0,20,1,5] w
    sp5 <-mkSpinboxWithTitle "cross" [0,4,1,3] w
    button <- UI.button # set UI.text "compute"
    getBody w #+ [element button]
    mkLabel "spokeLength(mm)" w
    l <- UI.input # set (attr "value") "show here, 2 sets of spokes" 
    getBody w #+ [element l]
    on UI.click button $ const $ do 
        sl <- mapM (get value) [sp0,sp1,sp2,sp3,sp4,sp5]
        dl <- liftIO $ mapM toD sl
        splenRL <- liftIO $ splen dl
        let txt = show splenRL
        element l # set (attr "value") txt
dist(a,b)= return $ magnitude(a-b)
hosei = 2.4 / 2 
yen = pi * 2
fh pcd h k = return $ mkPolar  pcr (yen / (h / 2) * (k - 1) / 2) 
    where pcr= (pcd / 2)
fr d h = return $ mkPolar a (yen / h * (-1))
    where a =( d / 2)
hypo (l, z) = dist (a, b)
    where   a = 0 :+ 0
            b = l :+ z 
len erd h pcd flc k = do
    a <- fh pcd h k
    b <- fr erd h
    c <- dist (a,b)
    d <- hypo(c, flc)  
    return (d - hosei)
splen [erd,h,pcd,fw,offset,cross] = do
    let f2fc = fc - offset
    splen0 <- len erd h pcd f2fc k
    let leftf2fc = fc + offset
    splen1 <- len erd h pcd leftf2fc k
    return (splen0 ,splen1)
        where   fc = fw / 2
                k = cross * 2
