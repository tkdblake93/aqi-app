class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=75080&distance=0&API_KEY=88136DCF-8404-4E67-A410-46FDA7019EF4'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    # Check for valid ZIP code
    if @output.empty?
      @final_output = "Error"
    elsif !@output
      @final_output = "Error"
    else
      @final_output = @output[0]['AQI']
    end

    # Check for local area output
    if @output.empty?
      @local_output = "Error"
    elsif !@output
      @local_output = "Error"
    else
      @local_output = @output[0]['ReportingArea']
    end
    # Check for valid state
    if @output.empty?
      @state_output = "Error"
    elsif !@output
      @state_output = "Error"
    else
      @state_output = @output[0]['StateCode']
    end

    # Change Jumbotron border and AQI background color based on ozone air quality level
    case @final_output
    when 0..50
      @jumbo_border_color = "green"
      @aqi_bg_color = "green-bg"
      @aqi_description = "AQI: Good (0 - 50)"
    when 51..100
      @jumbo_border_color = "yellow"
      @aqi_bg_color = "yellow-bg"
      @aqi_description = "AQI: Moderate (51 - 100)"
    when 101..150
      @jumbo_border_color = "orange"
      @aqi_bg_color = "orange-bg"
      @aqi_description = "AQI: Unhealthy for Sensitive Groups (101 - 150)"
    when 151..200
      @jumbo_border_color = "red"
      @aqi_bg_color = "red-bg"
      @aqi_description = "AQI: Unhealthy (151 - 200)"
    when 201..300
      @jumbo_border_color = "purple"
      @aqi_bg_color = "purple-bg"
      @aqi_description = "AQI: Very Unhealthy (201 - 300)"
    when 301..500
      @jumbo_border_color = "maroon"
      @aqi_bg_color = "maroon-bg"
      @aqi_description = "AQI: Hazardous (301 - 500)"
    else
      @jumbo_border_color = "gray"
      @aqi_bg_color = "gray-bg"
    end
  end

  def zipcode
    @zip_query = params[:zipcode]

    if params[:zipcode] == ""
      @zip_query = "No ZIP Code was entered."
    elsif params[:zipcode]
      # Do API stuff

      require 'net/http'
      require 'json'

      @url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @zip_query + '&distance=0&API_KEY=88136DCF-8404-4E67-A410-46FDA7019EF4'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)

      # Check for valid ZIP code
      if @output.empty?
        @final_output = "Error"
      elsif !@output
        @final_output = "Error"
      else
        @final_output = @output[0]['AQI']
      end

      # Check for local area output
      if @output.empty?
        @local_output = "Error"
      elsif !@output
        @local_output = "Error"
      else
        @local_output = @output[0]['ReportingArea']
      end
      # Check for valid state
      if @output.empty?
        @state_output = "Error"
      elsif !@output
        @state_output = "Error"
      else
        @state_output = @output[0]['StateCode']
      end

      # Change Jumbotron border and AQI background color based on ozone air quality level
      case @final_output
      when 0..50
        @jumbo_border_color = "green"
        @aqi_bg_color = "green-bg"
        @aqi_description = "AQI: Good (0 - 50)"
      when 51..100
        @jumbo_border_color = "yellow"
        @aqi_bg_color = "yellow-bg"
        @aqi_description = "AQI: Moderate (51 - 100)"
      when 101..150
        @jumbo_border_color = "orange"
        @aqi_bg_color = "orange-bg"
        @aqi_description = "AQI: Unhealthy for Sensitive Groups (101 - 150)"
      when 151..200
        @jumbo_border_color = "red"
        @aqi_bg_color = "red-bg"
        @aqi_description = "AQI: Unhealthy (151 - 200)"
      when 201..300
        @jumbo_border_color = "purple"
        @aqi_bg_color = "purple-bg"
        @aqi_description = "AQI: Very Unhealthy (201 - 300)"
      when 301..500
        @jumbo_border_color = "maroon"
        @aqi_bg_color = "maroon-bg"
        @aqi_description = "AQI: Hazardous (301 - 500)"
      else
        @jumbo_border_color = "gray"
        @aqi_bg_color = "gray-bg"
      end
    end
  end
end
