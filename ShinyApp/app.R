# Load required libraries
library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(readr)
library(fontawesome)
library(rvest)
library(plyr)
library(scales)
library(zoo)
library(openair)

city_urls <- list(
  "Bangalore" = "https://www.easeweather.com/asia/india/karnataka/bangalore-urban/bengaluru/today",
  "Bhopal" = "https://www.easeweather.com/asia/india/madhya-pradesh/bhopal/today",
  "Delhi" = "https://www.easeweather.com/asia/india/delhi/delhi/today",
  "Chennai" = "https://www.easeweather.com/asia/india/tamil-nadu/chennai/today",
  "Hyderabad" = "https://www.easeweather.com/asia/india/telangana/hyderabad/today",
  "Kanpur" = "https://www.easeweather.com/asia/india/uttar-pradesh/kanpur/today",
  "Kolkata" = "https://www.easeweather.com/asia/india/west-bengal/kolkata/today",
  "Lucknow" = "https://www.easeweather.com/asia/india/uttar-pradesh/lucknow-district/lucknow/today",
  "Mumbai" = "https://www.easeweather.com/asia/india/maharashtra/mumbai-suburban/mumbai/today",
  "Patna" = "https://www.easeweather.com/asia/india/bihar/patna/today",
  "Varanasi" = "https://www.easeweather.com/asia/india/uttar-pradesh/varanasi/today",
  "Shimla" = "https://www.easeweather.com/asia/india/himachal-pradesh/shimla/today",
  "Guwahati" = "https://www.easeweather.com/asia/india/assam/kamrup-metropolitan/guwahati/today",
  "Dehradun" = "https://www.easeweather.com/asia/india/uttarakhand/dehradun/dehra-dun/today",
  "Pune" = "https://www.easeweather.com/asia/india/maharashtra/pune-division/pune/today"
)

# Function to calculate predominant wind direction
get_predominant_wind_direction <- function(wind_direction_data) {
  direction_counts <- table(wind_direction_data)
  predominant_direction <- names(sort(direction_counts, decreasing = TRUE)[1])
  return(predominant_direction)
}

weather_now <- function(city){
  url <- city_urls[[city]]
  weather_page <- read_html(url)
  data_today <- html_elements(weather_page, ".data-point-label") %>% html_text()
  
  # Return weather data as a list or data frame
  weather_data <- data.frame(
    Temperature = data_today[1],
    Precipitation = data_today[2],
    Wind_speed = data_today[3],
    Humidity = data_today[4]
  )
  
  return(weather_data)
}

hourly_weather_now <- function(city) {
  url <- city_urls[[city]]
  weather_page <- read_html(url)
  
  # Extract the table
  data_today <- weather_page %>% html_table()
  data_today <- data_today[[1]]
  
  # Find the row where the first element is "Temperatures"
  temperature_row <- data_today[data_today[[1]] == "temperatures", ]
  
  
  hours <-colnames(data_today)[-1]
  #icon = ifelse(as.numeric(hours) >= 6 & as.numeric(hours) <= 18, "☀️", "🌙")
  # Create a new data frame with the extracted row and corresponding column names
  temperature_df <- data.frame(time = hours,
                               temperature = as.character(temperature_row[-1])
  )
  return(temperature_df)
  
}

# Define city data
cities <- data.frame(
  name = c("Bangalore", "Chennai", "Delhi", "Lucknow", 
           "Mumbai", "Kolkata", 
           "Kanpur", "Varanasi", "Shimla", "Patna", 
           "Hyderabad", "Guwahati", "Dehradun", "Bhopal", "Pune"),
  lat = c(12.9716, 13.0827, 28.6139, 26.8467, 
          19.0760,  22.2604, 
          26.4499, 25.3176, 31.1048, 25.5941, 
          17.3850, 26.1445, 30.3165, 23.2599, 18.5196),
  lon = c(77.5946, 80.2707, 77.2090, 80.9462, 
          72.8777, 84.8536, 
          80.3319, 82.9739, 77.1734, 85.1376, 
          78.4867, 91.7362, 78.0322, 77.4126, 73.8554),
  elev = c(920, 6, 216, 123, 14,
           219, 126, 81, 2205, 53, 
           542, 55, 435, 527, 554)
)

# Define the UI
ui <- fluidPage(
  tags$head(includeCSS("www/styles.css")), # Link to custom CSS file
  
  titlePanel(div("Sky Insight", class = "title-panel")),
  
  sidebarLayout(
    sidebarPanel(
      class = "sidebar-panel",
      selectInput("city", "Select a city:", choices = cities$name, selected = "Kanpur"),
      dateRangeInput("dateRange", "Select Date Range:", start = "2023-01-01", end = "2023-12-31", min = "2022-01-01", max = "2024-10-27"),
      #selectInput("variable", "Select Variable:", choices = c("Average Temperature" = "Average_Temperature", "Maximum Temperature" = "Maximum_Temperature", "Minimum Temperature" = "Minimum_Temperature", "Precipitation" = "Precipitation", "Wind Speed" = "Wind_Speed", "Wind Direction" = "Wind_Direction", "Air Pressure" = "Air_Pressure")),
      selectInput("plot_type", "Choose a Plot", choices = c(
        "Temperature Time Series",
        "Wind Rose Plot",
        "Precipitation Over Time",
        "Air Pressure Trend",
        "Temperature Heatmap")
      ),
      #selectInput("analysisType", "Select Analysis Type:", choices = c("Temperature Time Series", "Wind Speed and Direction", "Precipitation Over Time", "Air Pressure Trend", "Calendar Heatmap")),
      #textOutput("city_info", container = span),
      h4("Map Location"),
      div(class = "map-container", leafletOutput("map", width = "100%", height = "400px"))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Forecast", div(class = "forecast-section",
                                 h3(textOutput("dynamicTitle"), class = "highlight-title"),
                                 uiOutput("currentWeather"),  
                                 h3("Forecast for the Day", class = "forecast-title"),
                                 plotOutput("forecastPlot", height = "400px") 
        )
        ),
        tabPanel("Data Analysis", 
                 plotOutput("weatherPlot", width = "100%", height = "400px"),
                 # Summary Text
                 div(class = "data-summary", tableOutput("dynamic_summary_table"))
                 
          )  
        )
      
    )
  )
)


# Define the server logic
server <- function(input, output, session) {
  
  output$dynamicTitle <- renderText({
    paste("Today's Weather for", input$city)
  })
  
  current_weather <- reactive({
    req(input$city)  
    weather_now(input$city)
  })
  
  # Display current weather
  output$currentWeather <- renderUI({
    weather <- current_weather()
    if (is.null(weather)) {
      return("Weather data not available")
    }
    
    # Customize this as per the UI design
    tagList(
      div(class = "highlight-box", h4("Wind Speed"), h1(weather$Wind_speed)),
      div(class = "highlight-box", h4("Humidity"), h1(weather$Humidity)),
      div(class = "highlight-box", h4("Precipitation"), h1(weather$Precipitation)),
      div(class = "highlight-box", h4("Temprature"), h1(weather$Temperature)),
    )
  })
  # Hourly analysis 
  # Sample data for 24 hours (replace this with your actual data)
  hourly_weather <- reactive({
    req(input$city)  
    hourly_weather_now(input$city)
  })
  
  
  # Render the plot
  # Render the forecast plot
  output$forecastPlot <- renderPlot({
    data <- hourly_weather()
    data$Temperature <- data$temperature
    data$temperature <- as.numeric(gsub("°", "", data$temperature))
    # Filter out non-numeric values for plotting
    # Create the plot
    ggplot(data, aes(x = time, y = temperature)) +
      geom_line(color = "#F0A500", size = 1.2) +
      geom_point(color = "#F0A500", size = 4) +
      geom_text(aes(label = paste0(temperature, "°")), vjust = -1, color = "white", size = 4) +
      # Add annotations for Sunrise and Sunset
      geom_vline(xintercept = data$time[data$Temperature== 'Sunrise'], color = "yellow", linetype = "dashed") +
      geom_text(aes(x =data$time[data$Temperature== 'Sunrise'],y=5), label = "Sunrise", color = "yellow", vjust = -1) +
      geom_vline(xintercept = data$time[data$Temperature== "Sunset"], color = "orange", linetype = "dashed") +
      geom_text(aes(x = data$time[data$Temperature== "Sunset"], y = 5), label = "Sunset", color = "orange", vjust = -1) +
      theme_minimal(base_family = "Arial") +
      theme(
        plot.background = element_rect(fill = "#0c1c3a", color = NA),
        panel.background = element_rect(fill = "#0c1c3a"),
        panel.grid = element_blank(),
        axis.text.x = element_text(color = "white", size = 12),
        axis.text.y = element_text(color = "white", size = 12),
        axis.title = element_blank(),
        plot.title = element_text(color = "white", size = 16, face = "bold", hjust = 0.5)
      ) +
      scale_y_continuous(limits = c(5, 35)) +
      ggtitle(paste0("24-Hour Temperature Forecast for ", input$city))
  })
  # Leaflet map with city marker
  selected_city <- reactive({
    cities[cities$name == input$city, ]
  })
  output$map <- renderLeaflet({
    city <- selected_city()
    leaflet() %>%
      addTiles() %>%
      setView(lng = city$lon, lat = city$lat, zoom = 5) %>%
      addMarkers(lng = city$lon, lat = city$lat, popup = paste("<b>", city$name, "</b>"))
  })
  output$city_info <- renderText({ paste("Currently selected:", input$city) })
  
  # Load and filter city data for data analysis
  city_data <- reactive({
    file_path <- paste0("../Data/Data_Cleaned/", input$city, ".csv")
    if (!file.exists(file_path)) {
      return(NULL)
    }
    data <- read_csv(file_path, show_col_types = FALSE)
    data$Date <- as.Date(data$Date)
    return(data)
  })
  
  filtered_data <- reactive({
    city_data() %>%
      filter(Date >= input$dateRange[1] & Date <= input$dateRange[2])
  })
  
  # Generate plots based on analysis type
  output$weatherPlot <- renderPlot({
    data <- filtered_data()
    
    # Check if data is loaded and contains rows
    if (is.null(data) || nrow(data) == 0) {
      showNotification("No data available for the selected date range or city.")
      return(NULL)
    }
    
    # Check if required columns are present in data
    required_cols <- c("Date", "Average_Temperature", "Air_Pressure", "Precipitation")
    missing_cols <- setdiff(required_cols, names(data))
    if (length(missing_cols) > 0) {
      showNotification(paste("Missing required columns:", paste(missing_cols, collapse = ", ")), type = "error")
      return(NULL)
    }
    plot_type <- input$plot_type
    # Plot based on the selected analysis type
    if (plot_type == "Temperature Time Series") {
      ggplot(data, aes(x = Date)) +
        geom_line(aes(y = Average_Temperature, color = "Average")) +
        geom_line(aes(y = Maximum_Temperature, color = "Max")) +
        geom_line(aes(y = Minimum_Temperature, color = "Min")) +
        labs(title = "Daily Temperature Trends", y = "Temperature (°C)", color = "Legend") +
        theme_minimal()
      
    } else if (plot_type == "Wind Rose Plot") {
      windRose(data, ws = "Wind_Speed", wd = "Wind_Direction", main = "Wind Speed and Direction")
      
    } else if (plot_type == "Precipitation Over Time") {
      ggplot(data, aes(x = Date, y = Precipitation)) +
        geom_col(fill = "skyblue") +
        labs(title = "Daily Precipitation", y = "Precipitation (mm)") +
        theme_minimal()
      
      
    } else if (plot_type == "Air Pressure Trend") {
      ggplot(data, aes(x = Date, y = Air_Pressure)) +
        geom_line(color = "purple") +
        labs(title = "Air Pressure Trend", y = "Air Pressure (hPa)") +
        theme_minimal()
      
    }else if(plot_type == "Temperature Heatmap") {
      # Prepare data for calendar heatmap
      data$year <- as.numeric(format(data$Date, "%Y"))
      data$monthf <- factor(format(data$Date, "%b"), levels = month.abb)
      data$weekdayf <- factor(weekdays(data$Date), levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
      data$yearmonth <- as.yearmon(data$Date)
      data$yearmonthf <- factor(data$yearmonth)
      data$week <- as.numeric(format(data$Date, "%U"))
      data <- ddply(data, .(yearmonthf), transform, monthweek = 1 + week - min(week))
      
      # Plot the heatmap
      ggplot(data, aes(monthweek, weekdayf, fill = .data[["Average_Temperature"]])) + 
        geom_tile(colour = "white") + 
        facet_grid(year ~ monthf) + 
        scale_fill_gradient(low = "blue", high = "red") + 
        labs(x = "Week of Month", y = "", title = "Time-Series Calendar Heatmap", subtitle = paste("Temperature", "in", input$city), fill = input$variable)
    }
  })
  output$dynamic_summary_table <- renderTable({
    data <- filtered_data()
    
    if (nrow(data) == 0) {
      return(data.frame(Message = "No data available for the selected city and date range."))
    }
    
    # Switch case for plot type
    if (input$plot_type == "Temperature Time Series"|input$plot_type == "Temperature Heatmap") {
      # Temperature Summary
      temp_stats <- data.frame(
        Metric = c("Max Temperature (°C)", "Min Temperature (°C)", "Average Temperature (°C)"),
        Value = c(
          max(data$Maximum_Temperature, na.rm = TRUE),
          min(data$Minimum_Temperature, na.rm = TRUE),
          mean(data$Average_Temperature, na.rm = TRUE)
        )
      )
      return(temp_stats)
      
    } else if (input$plot_type == "Wind Rose Plot") {
      # Wind Summary
      wind_stats <- data.frame(
        Metric = c("Max Wind Speed (km/h)", "Min Wind Speed (km/h)", "Average Wind Speed (km/h)", "Predominant Wind Direction"),
        Value = c(
          max(data$Wind_Speed, na.rm = TRUE),
          min(data$Wind_Speed, na.rm = TRUE),
          mean(data$Wind_Speed, na.rm = TRUE,round(2)),
          get_predominant_wind_direction(data$Wind_Direction)
        )
      )
      return(wind_stats)
      
    } else if (input$plot_type == "Precipitation Over Time") {
      # Precipitation Summary
      precip_stats <- data.frame(
        Metric = c("Max Precipitation (mm)", "Min Precipitation (mm)", "Average Precipitation (mm)","Corelation Between Precipitaion and Pressure"),
        Value = c(
          max(data$Precipitation, na.rm = TRUE),
          min(data$Precipitation, na.rm = TRUE),
          mean(data$Precipitation, na.rm = TRUE),
          cor(data$Air_Pressure,data$Precipitation, use = "complete.obs")
        )
      )
      return(precip_stats)
      
    } else if (input$plot_type == "Air Pressure Trend") {
      # Air Pressure Summary
      pressure_stats <- data.frame(
        Metric = c("Max Air Pressure (hPa)", "Min Air Pressure (hPa)", "Average Air Pressure (hPa)","Corelation Between Precipitaion and Pressure"),
        Value = c(
          max(data$Air_Pressure, na.rm = TRUE),
          min(data$Air_Pressure, na.rm = TRUE),
          mean(data$Air_Pressure, na.rm = TRUE),
          cor(data$Air_Pressure,data$Precipitation, use = "complete.obs")
        )
      )
      return(pressure_stats)
      
    } 
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
