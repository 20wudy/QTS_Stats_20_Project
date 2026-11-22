df_achievements <- data.frame(
  name_1 = c("first_win","ten_wins","three_sectors","beat_bots",
  "on_time"),
  
  name = c("First Win","Ten Wins","Three Sectors","Beat the Bots",
  "On Time"),
  
  unlocked = rep(FALSE, 5)
)

win_sales <- 10
# First Win
if (win_sales >= 1){
  df_achievements$unlocked[df_achievements$name_1 == "first_win"] <- TRUE
}

# Ten Wins
if (win_sales >= 10){
  df_achievements$unlocked[df_achievements$name_1 == "ten_wins"] <- TRUE
}

# player's stock
player_stock <- data.frame(
  sector = c("a","b","c")
)

sector_number <- length(unique(player_stock$sector))

# Three Sectors
if(sector_number >= 3){
  df_achievements$unlocked[df_achievements$name_1 == "three_sectors"]<- TRUE
}

# Beat the Bots
player_value <- 2
bot_value <- 1
if (player_value > bot_value){
  df_achievements$unlocked[df_achievements$name_1 == "beat_bots"]<- TRUE
}

# On Time
player_value <- 2
target <- 3
timer <- 10

if (player_value >= target & timer >0){
  df_achievements$unlocked[df_achievements$name_1 == "on_time"] <- TRUE
}



# panel
cat("$$$$$$$$$$$$$$$$------  Achievements Panel  ------$$$$$$$$$$$$$$$$\n")

# First Win
if (df_achievements$unlocked[1] == TRUE){
  cat("*Unlocked*   First Win\n")
} else {cat("*Locked*   First Win\n")}

# Ten Wins
if (df_achievements$unlocked[2]== TRUE){
  cat("*Unlocked*   Ten Wins\n")
} else {cat("*Locked*   Ten Wins\n")}


# Three Sectors
if (df_achievements$unlocked[3]== TRUE){
  cat("*Unlocked*   Three Sectors\n")
} else {cat("*Locked*   Three Sectors\n")}

# Beat the Bots
if (df_achievements$unlocked[4]== TRUE){
  cat("*Unlocked*   Beat the Bots\n")
} else {cat("*Locked*   Beat the Bots\n")}

# On Time
if (df_achievements$unlocked[5]== TRUE){
  cat("*Unlocked*   On Time\n")
} else {cat("*Locked*   On Time\n")}






















