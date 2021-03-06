class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split_into_array = @text.split

    spaces_removed = @text.gsub(" ", "")

    text_in_lowercase = @text.downcase

    lowercase_punctuation_removed = text_in_lowercase.gsub(/[^a-z0-9\s]/i, "")

    split_text = lowercase_punctuation_removed.split

    special_word_lowercase = @special_word.downcase

    @word_count = text_split_into_array.length

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = spaces_removed.length

    @occurrences = split_text.count(special_word_lowercase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (((@apr/100)/12) / (1 - (1 + ((@apr/100)/12)) ** (-(@years*12)))) * @principal

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    seconds_between = @ending - @starting

    @seconds = seconds_between
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    center = @count / 2

    if @count.even?
      median = (@sorted_numbers[center+1] + @numbers[center-1]) / 2
    else
      median = @sorted_numbers[center]
    end

    @median = median

    @sum = @numbers.sum

    @mean = @sum / @count

    mean = @mean

      squared_diffs = []

        @numbers.each do |number|
          mean_diff = (number - mean)
          squared_mean_diff = mean_diff ** 2
          squared_diffs.push(squared_mean_diff)
        end

    @variance = squared_diffs.sum / squared_diffs.count

    @standard_deviation = @variance ** 0.5

    @mode = "X"

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
