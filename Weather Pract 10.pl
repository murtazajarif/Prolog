% Sample climate data
% Temperature in Celsius for each day
temperature_data([20, 22, 25, 24, 23, 21, 19, 18, 17, 16]).

% Predicate to calculate the average temperature
average_temperature(TemperatureList, AverageTemperature) :-
    sum_list(TemperatureList, Sum),
    length(TemperatureList, Length),
    AverageTemperature is Sum / Length.

% Predicate to make a simple weather prediction based on average temperature
weather_prediction(AverageTemperature) :-
    AverageTemperature > 25,
    write('It might be a warm day!').
weather_prediction(AverageTemperature) :-
    AverageTemperature > 15,
    write('Expect a moderate temperature.').
weather_prediction(AverageTemperature) :-
    write('It might be a cool day.').

% Entry point to analyze climate data
analyze_climate_data :-
    temperature_data(Temperatures),
    average_temperature(Temperatures, AvgTemp),
    write('Average Temperature: '), write(AvgTemp), nl,
    weather_prediction(AvgTemp).

% Start the climate analysis
:- analyze_climate_data.
