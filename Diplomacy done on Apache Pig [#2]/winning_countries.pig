-- Load the players.csv file
data = LOAD '/home/maria_dev/data/players.csv' USING PigStorage(',') AS (game_id, country, won, num_supply_centers, eliminated, start_turn, end_turn);

-- Filter for records where won = 1 (indicating a win)
winners = FILTER data BY won == '"1"';

-- Group by country and calculate the sum of wins
country_wins = FOREACH (GROUP winners BY country) GENERATE group AS country, COUNT(winners) AS total_wins;

-- Dump the result
DUMP country_wins;