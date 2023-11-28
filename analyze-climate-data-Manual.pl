% Facts for temperature and humidity for the next two days
temperature(today, 25).
temperature(yesterday, 22).
temperature(tomorrow, 28).   % Add temperature for tomorrow
temperature(day_after_tomorrow, 30).   % Add temperature for the day after tomorrow

humidity(today, 60).
humidity(yesterday, 55).
humidity(tomorrow, 65).   % Add humidity for tomorrow
humidity(day_after_tomorrow, 70).   % Add humidity for the day after tomorrow

% Rules for Weather Prediction (Modify based on your climate model)
predict(weather, today) :-
    temperature(today, Temp),
    humidity(today, Humidity),
    % Rule 1: If temperature is high and humidity is high, predict "Hot and Humid"
    Temp > 30, Humidity > 70,
    write('Weather Prediction for today: Hot and Humid'), nl.
predict(weather, today) :-
    temperature(today, Temp),
    humidity(today, Humidity),
    % Rule 2: If temperature is moderate and humidity is moderate, predict "Mild"
    Temp >= 20, Temp =< 30, Humidity >= 40, Humidity =< 70,
    write('Weather Prediction for today: Mild'), nl.
predict(weather, tomorrow) :-
    temperature(tomorrow, Temp),
    humidity(tomorrow, Humidity),
    % Rule 3: Customize rules for tomorrow
    % ... add your own rules based on temperature and humidity for tomorrow
    write('Weather Prediction for tomorrow: Humid'), nl.
predict(weather, day_after_tomorrow) :-
    temperature(day_after_tomorrow, Temp),
    humidity(day_after_tomorrow, Humidity),
    % Rule 4: Customize rules for the day after tomorrow
    % ... add your own rules based on temperature and humidity for the day after tomorrow
    write('Weather Prediction for the day after tomorrow: Mild Humid and Modarate Hot.'), nl.
predict(weather, _) :-
    % Rule 5: Default prediction if no specific rules apply
    write('Weather Prediction: Not enough data for a specific prediction.'), nl.

% Example Usage - predict(weather, today).
% Example Usage - predict(weather, tomorrow).
% Example Usage - predict(weather, day_after_tomorrow).
% Example Usage - predict(weather, unknown_day).
