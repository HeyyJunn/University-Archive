# Homework Assignment 7
# Name: 김민준
# Time Spent: 2:30


# -----------------------------------
# Helper code
# (you don't need to understand this helper code)
import random
import string

WORDLIST_FILENAME = "words.txt"

def load_words():
    """
    Returns a list of valid words. Words are strings of lowercase letters.

    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print ("Loading word list from file...")
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r')
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = line.split(" ")

    print (len(wordlist), "words loaded.")
    return wordlist

def choose_word(wordlist):
    """
    wordlist (list): list of words (strings)

    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code
# -----------------------------------

# actually load the dictionary of words and point to it with
# the wordlist variable so that it can be accessed from anywhere
# in the program
wordlist = load_words()

# your code begins here!
# 아직 추측하지 않은 글자들
def available_letters(secret_word, letters_guessed):
    available_letters_list = "abcdefghijklmnopqrstuvwxyz"
    result = ""
    for letter in available_letters_list:
        if letter not in letters_guessed:
            result += letter
    return result

# 이미 사용자가 추측한 글자목록들
def guessed_letters(secret_word, letters_guessed):
    result = ""
    for letter in secret_word:
        if letter in letters_guessed:
            result += letter
        else:
            result += "_"
    return result

def is_word_correct(secret_word, letters_guessed):
    for letter in secret_word:
        if letter not in letters_guessed:
            return False
    return True

def hangman():
    letters_guessed = []
    guesses_left = 10
    secret_word = choose_word(wordlist)

    print("Welcome to the game, Hangman!")
    print("I am thinking of a word that is "
          + str(len(secret_word))
          + " letters long.")

    while guesses_left > 0:

        print("------------")
        print("You have " + str(guesses_left) + " guesses left.")

        print("Available letters: " + str(available_letters(secret_word, letters_guessed)))
        guess = input("Please guess a letter: ").lower()
        letters_guessed.append(guess)

        if guess in secret_word:
            print("Good guess:" + str(guessed_letters(secret_word, letters_guessed)))
        else:
            print("Oops! That letter is not in my word: " + str(guessed_letters(secret_word, letters_guessed)))
            guesses_left -= 1

        if is_word_correct(secret_word, letters_guessed):
            print("------------")
            print("Congratulations, you won!")
            break

    if not is_word_correct(secret_word, letters_guessed):
        print("You lose. The word was:", secret_word)

hangman()
