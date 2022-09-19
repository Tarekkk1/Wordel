# Wordel
Project made using prolog (logic programing language ) this project was made as an apply way for concepts of programing language we learnedhow to deal with logic language and when we use it.
## To run the project :
### 1: Download the full project .
### 2: Run it on prolog compiler environment.
## More details
 The Pro-Wordle game is made up of two main phases:
(1) a knowledge base building phase and (2) a game play phase.
In the KB building phase, the player is prompted to enter words with their categories.
Corresponding facts are added to the KB using the predicate word/2 where word(W,C)
is true if W has a category of C. This continues until the player enters done. Below is a
sample of the interaction between the game and the player in the KB building phase.
After the KB building phase, the game play phase begins. The game displays to the user
the available categories to pick one from. The player is then prompted to pick a length
and category for the word to be guessed. The game picks a word of the given length and
category and the guessing game begins. The player is allowed a maximum number of
guesses equal to the entered length plus one. In each guess, the user must enter a word of
the chosen length. The game then displays to the user the correctly entered letters (not
necessarily in correct positions), and the correctly entered letters in correct positions.
Below is a sample of the interaction between the game and the player in the game play
phase based on the example KB provided earlier.

