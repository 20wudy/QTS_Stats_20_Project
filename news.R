# ==========================================
# QTS - News System
# Responsible: Siying Qiu
# ==========================================

# Tasks:
# 1. Create around 15 predefined news events.
# 2. Randomly release news at different intervals.
# 3. Record published headlines and timestamps.
# 4. Prevent the same headline from appearing twice in a row.
# 5. Connect news events to stock price changes.

library(htmltools)

# 1. CREATE 15 NEWS EVENTS
news_events <- data.frame(
  id = 1:15,
  
  topics = c(
    "NVIDIA Forecasts Strong Revenue Growth Driven by AI Demand",
    "Tesla Reports Record Vehicle Deliveries in 2023",
    "Microsoft Announces Major Investment in OpenAI",
    "Apple Introduces New AI Features",
    "Google Loses Major Antitrust Case",
    "Federal Reserve Raises Interest Rates to Fight Inflation",
    "Federal Reserve Cuts Interest Rates by 0.5 Percentage Points",
    "U.S. Inflation Reaches 9.1%, Highest in Four Decades",
    "Silicon Valley Bank Collapses",
    "WHO Declares COVID-19 a Global Pandemic",
    "OPEC+ Announces Additional Oil Production Cuts",
    "SEC Approves Spot Bitcoin Exchange-Traded Products",
    "Pfizer Announces Promising COVID-19 Vaccine Results",
    "U.S. Announces Major Oil Release from Strategic Reserves",
    "Apple Unveils the First iPhone"
  ),
  
  contents = c(
    "NVIDIA announced a strong revenue forecast as demand for artificial intelligence chips continued to grow. The company expected higher sales from its data center business, attracting significant attention from investors.",
    "Tesla announced that it delivered approximately 1.81 million vehicles in 2023, setting a new company record. The results showed strong annual growth, although competition in the electric vehicle market continued to increase.",
    "Microsoft announced a multiyear, multibillion-dollar investment in OpenAI to expand their partnership in artificial intelligence. The agreement aimed to strengthen Microsoft's AI technology and cloud computing services.",
    "Apple introduced Apple Intelligence, a new artificial intelligence system designed for iPhones, iPads, and Macs. The company announced features that would help users write, organize information, and interact with their devices more efficiently.",
    "A U.S. federal judge ruled that Google had illegally maintained a monopoly in the online search market. The decision raised concerns about possible legal restrictions on Google's business operations and future growth.",
    "The Federal Reserve raised its benchmark interest rate by 0.25 percentage points to control rising inflation. Higher borrowing costs could reduce consumer spending and business investment, creating uncertainty in financial markets.",
    "The Federal Reserve announced a 0.5 percentage point interest rate cut as inflation pressures eased. Lower interest rates could encourage borrowing and investment, potentially supporting economic growth.",
    "U.S. consumer prices increased by 9.1% over the previous year, reaching the highest inflation rate in about 40 years. Rising costs for food, energy, and housing created financial pressure on households and businesses.",
    "Silicon Valley Bank collapsed after experiencing large withdrawals and financial difficulties. The failure raised concerns about the stability of other regional banks and increased uncertainty in the banking sector.",
    "The World Health Organization declared COVID-19 a global pandemic as the virus spread across multiple countries. The outbreak caused major disruptions to travel, manufacturing, and global business activity, increasing uncertainty in financial markets.",
    "Several OPEC+ countries announced voluntary oil production cuts to support market stability. The decision reduced expected global oil supply and created upward pressure on oil prices.",
    "The U.S. Securities and Exchange Commission approved the listing and trading of several spot Bitcoin exchange-traded products. The decision allowed investors to gain exposure to Bitcoin through traditional brokerage accounts without directly holding the cryptocurrency.",
    "Pfizer and BioNTech announced that their COVID-19 vaccine candidate showed more than 90% efficacy in an early analysis of Phase 3 trial results. The announcement increased hopes for economic recovery and attracted investor attention to the pharmaceutical industry.",
    "The U.S. government announced plans to release approximately one million barrels of oil per day from its strategic petroleum reserves for six months. The decision aimed to increase oil supply and reduce pressure on energy prices.",
    "Apple introduced the first iPhone, combining a mobile phone, music player, and internet communication device into one product. The announcement marked an important step in the development of smartphones and opened new business opportunities for Apple."
  ),
  
  time = c(
    "MAY 24, 2023",
    "JAN 2, 2024",
    "JAN 23, 2023",
    "JUN 10, 2024",
    "AUG 5, 2024",
    "MAR 16, 2022",
    "SEP 18, 2024",
    "JUL 13, 2022",
    "MAR 10, 2023",
    "MAR 11, 2020",
    "APR 2, 2023",
    "JAN 10, 2024",
    "NOV 9, 2020",
    "MAR 31, 2022",
    "JAN 9, 2007"
  ),
  
  target = c(
    "NVIDIA (NVDA)",
    "Tesla (TSLA)",
    "Microsoft (MSFT)",
    "Apple (AAPL)",
    "Alphabet (GOOGL)",
    "Overall Market",
    "Overall Market",
    "Overall Market",
    "Banking Sector",
    "Overall Market",
    "Energy Sector",
    "Bitcoin / Crypto",
    "Pfizer (PFE)",
    "Energy Sector",
    "Apple (AAPL)"
  ),
  
  price_change = c(
    0.12, 0.05, 0.06,
    0.07, -0.06, -0.04,
    0.04, -0.06, -0.10,
    -0.12, 0.07, 0.08,
    0.09, -0.05, 0.10
  )
)


# 2. INITIAL SETTINGS

# Remember the previous news
last_news_id <- 0

# Store published news
news_history <- data.frame(
  headline = character(),
  timestamp = character()
)

# 3. RANDOM NEWS FUNCTION
random_news <- function() {
  
  # Select random news
  news_id <- sample(1:nrow(news_events), 1)
  
  # Prevent the same news twice in a row
  while (news_id == last_news_id) {
    news_id <- sample(1:nrow(news_events), 1)
  }
  
  # Get selected news
  news <- news_events[news_id, ]
  
  # Remember the news ID
  last_news_id <<- news_id
  
  # Record headline and publication time
  news_history[nrow(news_history) + 1, ] <<- list(
    news$topics,
    as.character(Sys.time())
  )
  
  
  # 4. HTML NEWS DISPLAY
  
  color <- if (news$price_change > 0) {
    "green"
  } else {
    "red"
  }
  
  news_page <- tags$div(
    
    style = "font-family: Arial; padding: 20px;",
    
    tags$h1(
      style = "font-size: 30px;",
      "BREAKING NEWS"
    ),
    
    tags$h2(
      style = "font-size: 24px;",
      news$topics
    ),
    
    tags$p(
      style = "color: gray; font-size: 14px;",
      news$time
    ),
    
    tags$p(
      style = "font-size: 17px; line-height: 1.6;",
      news$contents
    ),
    
    tags$hr(),
    
    tags$p(
      paste("Affected Stock:", news$target)
    ),
    
    tags$p(
      style = paste0(
        "color:", color, "; font-size: 22px;"
      ),
      paste0(
        "Price Change: ",
        sprintf("%+.0f", news$price_change * 100),
        "%"
      )
    )
  )
  
  # Open news in RStudio Viewer
  html_file <- tempfile(fileext = ".html")
  save_html(news_page, html_file)
  rstudioapi::viewer(html_file)
  
  return(invisible(news))
}


# 5. RANDOM NEWS RELEASE

release_news <- function() {
  
  for (i in 1:5) {
    
    # Random waiting time (3-10 seconds)
    wait_time <- sample(3:10, 1)
    
    Sys.sleep(wait_time)
    
    # Publish news
    random_news()
  }
}


# 6. STOCK PRICE TEST

test_stock_impact <- function() {
  
  stock_price <- 100
  
  # Generate a news event
  current_news <- random_news()
  
  # Apply simulated price change
  new_price <- stock_price *
    (1 + current_news$price_change)
  
  cat("Target:", current_news$target, "\n")
  cat("Original Price:", stock_price, "\n")
  cat("New Price:", round(new_price, 2), "\n")
}


# 7. TESTING (RUN MANUALLY)

# Generate one news event
# random_news()

# Release 5 news events at random intervals
# release_news()

# View news history
# print(news_history)

# Test stock price impact
# test_stock_impact()

