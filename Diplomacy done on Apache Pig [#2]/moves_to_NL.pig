-- Load the orders.csv file
orders = LOAD '/home/maria_dev/data/orders.csv' USING PigStorage(',');

-- Extract the source and destination fields from each tuple
locations = FOREACH orders GENERATE $3 AS source, $4 AS destination;

-- Filter for the destination "Holland"
holland_destinations = FILTER locations BY destination == '"Holland"';

-- Group the sources
grouped_sources = GROUP holland_destinations BY source;

-- Count the occurrences of "Holland" for each source
count_sources = FOREACH grouped_sources GENERATE group AS source, COUNT(holland_destinations) AS holland_count;

-- Add the target "Holland" and sort the list in alphabetical order
sorted_sources = ORDER count_sources BY source ASC;
result = FOREACH sorted_sources GENERATE source, '"Holland"' AS target, holland_count;

-- Dump the result
DUMP result;