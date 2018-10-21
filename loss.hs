import Data.List (unfoldr, intercalate)

isLoss :: Int -> Int -> Int -> Bool
isLoss size i j = do
    let isFrame dim = elem dim [0, size - 1, quot size 2]
    let isPart dim num den = dim == quot (num * size) den
    let isPartSet dim nums den = any (\num -> isPart dim num den) nums
    isFrame i || isFrame j
        || (isPartSet j [1, 4] 6 && not (isPartSet i [1, 5, 7, 11] 12))
        || (isPart j 2 6 && isPartSet i [8, 9, 10] 12)
        || (isPart j 5 6 && isPartSet i [3, 4] 12)
        || (isPart i 5 6 && isPartSet j [9, 10] 12)

build :: Int -> [[Bool]]
build size = do
    let f i = unfoldr (\j -> if j == size then Nothing else Just (isLoss size i j, j + 1)) 0
    unfoldr (\i -> if i == size then Nothing else Just (f i, i + 1)) 0

main = do
    let foo = build 13
    let bar = map (\x -> intercalate " " (map (\y -> if y then "#" else " ") x)) foo
    mapM_ putStrLn bar
