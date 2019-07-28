import NLP.PS
import Data.Text (pack)

--Cluster words by lexeme.

main = do
tagger <- defaultTagger
let text = pack "The best jokes have no punchline."
print $ tag tagger text
