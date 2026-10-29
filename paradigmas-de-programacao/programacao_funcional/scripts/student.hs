type Name = String
type UID = Int
type Score = Double

data Student = Student {
    studentName  :: Name,
    studentUID   :: UID,
    studentScore :: Score
} deriving (Show)

s = Student {
    studentName = "Fulano",
    studentUID = 123,
    studentScore = 9.2
}

main = print $ studentName s