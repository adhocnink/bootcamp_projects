print("Welcome to >> PAO YING CHUB GAME! <<")
print("Choose 'Rock' then pls type 'r'")
print("Choose 'Scissors' then pls type 's'")
print("Choose 'Paper' then pls type 'p'")
print("Quit Game: please type 'q'")

print("What's your name? ")
user_name <- readLines("stdin", n=1)
print( paste("Let's get started !!", user_name ))

#count
count <- 0
win <- 0
lose <- 0
tie <- 0
round <-0

while(count <- 10){
  round <- round +1
  print ( paste ("Round:", round, "!"))
  print("Your turn! Please choose 'r', 's', 'p'")
  user <- (readLines("stdin", n = 1))
  bot <- c("r", "s", "p")
  random <- sample(bot, size = 1) 
  
if (user == 'r' & random == 'r' ||
    user == 's' & random == 's' ||
    user == 'p' & random == 'p') {
  print(paste("You selected:", user))
  print(paste("Bot selected :", random))
  print("You Tie !")
  tie <- tie +1
 }
 
  else if (user == 'r' & random == 'p' ||
    user == 's' & random == 'r' ||
    user == 'p' & random == 's') {
  print(paste("You selected:", user))
  print(paste("Bot selected :", random))
  print("You Lose !")
  lose <- lose +1 
  }
 
  else if (user == 'r' & random == 's' ||
    user == 's' & random == 'p' ||
    user == 'p' & random == 'r') {
  print(paste("You selected:", user))
  print(paste("Bot selected :", random))
  print("You Win !")
  win <- win +1 
  }
  
  else if (user == "q") {
  print("Game Over !")
  print(paste("Win :", win, "times"))
  print(paste("Tie :", tie, "times"))
  print(paste("Lose :", lose, "times"))
  break
  }
  
}
