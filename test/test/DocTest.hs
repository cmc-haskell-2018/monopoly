import Test.DocTest

main :: IO ()
main = doctest ["-isrc", "src/Monopoly.hs"]
