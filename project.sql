CREATE TABLE f1_drivers (
    Driver VARCHAR(255),
    Nationality VARCHAR(100),
    Seasons TEXT,
    Championships DOUBLE,
    Race_Entries DOUBLE,
    Race_Starts DOUBLE,
    Pole_Positions DOUBLE,
    Race_Wins DOUBLE,
    Podiums DOUBLE,
    Fastest_Laps DOUBLE,
    Points DOUBLE,
    Active VARCHAR(10), -- Using string first to avoid boolean conversion errors
    Championship_Years TEXT,
    Decade INT,
    Pole_Rate DOUBLE,
    Start_Rate DOUBLE,
    Win_Rate DOUBLE,
    Podium_Rate DOUBLE,
    FastLap_Rate DOUBLE,
    Points_Per_Entry DOUBLE,
    Years_Active INT,
    Champion VARCHAR(10)
);


CREATE TABLE f1_teams (
    Team_ID INT PRIMARY KEY AUTO_INCREMENT,
    Team_Name VARCHAR(255) UNIQUE,
    Base_Location VARCHAR(100),
    Engine_Supplier VARCHAR(100),
    Total_Team_Championships INT DEFAULT 0
);

-- Sample Data to get you started
INSERT INTO f1_teams (Team_Name, Base_Location, Engine_Supplier, Total_Team_Championships)
VALUES 
-- The 2025 Grid
('Ferrari', 'Maranello, Italy', 'Ferrari', 16),
('McLaren', 'Woking, UK', 'Mercedes', 8),
('Mercedes', 'Brackley, UK', 'Mercedes', 8),
('Red Bull Racing', 'Milton Keynes, UK', 'Honda RBPT', 6),
('Williams', 'Grove, UK', 'Mercedes', 9),
('Aston Martin', 'Silverstone, UK', 'Mercedes', 0),
('Alpine', 'Enstone, UK', 'Renault', 2),
('Haas F1 Team', 'Kannapolis, USA', 'Ferrari', 0),
('RB Visa Cash App', 'Faenza, Italy', 'Honda RBPT', 0),
('Sauber (Audi)', 'Hinwil, Switzerland', 'Ferrari', 0),

-- Legendary Historical Teams
('Lotus', 'Hethel, UK', 'Climax/Ford', 7),
('Brabham', 'Milton Keynes, UK', 'Repco/Ford', 2),
('Tyrrell', 'Ockham, UK', 'Ford', 1),
('Benetton', 'Enstone, UK', 'Ford/Renault', 1),
('Brawn GP', 'Brackley, UK', 'Mercedes', 1),
('Jordan', 'Silverstone, UK', 'Mugen-Honda', 0);

CREATE TABLE f1_results_history (
    Result_ID INT PRIMARY KEY AUTO_INCREMENT,
    Driver_Name VARCHAR(255), -- This will link to your f1_drivers table
    Team_Name VARCHAR(255),   -- This will link to your f1_teams table
    Season_Year INT,
    Season_Points DOUBLE,
    Season_Rank INT,
    Wins_That_Season INT,
    FOREIGN KEY (Team_Name) REFERENCES f1_teams(Team_Name)
);

INSERT INTO f1_results_history (Driver_Name, Team_Name, Season_Year, Season_Points, Season_Rank, Wins_That_Season)
VALUES 
-- McLaren
('Lando Norris', 'McLaren', 2025, 412, 1, 8),
('Oscar Piastri', 'McLaren', 2025, 340, 3, 4),
-- Red Bull Racing
('Max Verstappen', 'Red Bull Racing', 2025, 385, 2, 7),
('Liam Lawson', 'Red Bull Racing', 2025, 112, 8, 0), -- Replaced Sergio Perez
-- Ferrari
('Charles Leclerc', 'Ferrari', 2025, 290, 4, 3),
('Lewis Hamilton', 'Ferrari', 2025, 265, 5, 2), -- Major 2025 Move
-- Mercedes
('George Russell', 'Mercedes', 2025, 245, 6, 2),
('Kimi Antonelli', 'Mercedes', 2025, 88, 11, 0), -- Rookie Debut
-- Aston Martin
('Fernando Alonso', 'Aston Martin', 2025, 95, 9, 0),
('Lance Stroll', 'Aston Martin', 2025, 42, 15, 0),
-- Williams
('Alex Albon', 'Williams', 2025, 58, 12, 0),
('Carlos Sainz', 'Williams', 2025, 140, 7, 0), -- Moved to Williams for 2025
-- Alpine
('Pierre Gasly', 'Alpine', 2025, 36, 16, 0),
('Jack Doohan', 'Alpine', 2025, 12, 19, 0), -- Rookie Debut
-- Haas
('Esteban Ocon', 'Haas F1 Team', 2025, 52, 13, 0),
('Oliver Bearman', 'Haas F1 Team', 2025, 24, 18, 0), -- Rookie Debut
-- RB (Visa Cash App)
('Yuki Tsunoda', 'RB Visa Cash App', 2025, 48, 14, 0),
('Isack Hadjar', 'RB Visa Cash App', 2025, 8, 20, 0), -- Rookie Debut
-- Sauber (Audi)
('Nico Hulkenberg', 'Sauber (Audi)', 2025, 30, 17, 0),
('Gabriel Bortoleto', 'Sauber (Audi)', 2025, 15, 18, 0), -- Rookie Debut

-- LEGENDARY RETIRED CHAMPIONS (Historical Data)
('Sebastian Vettel', 'Red Bull Racing', 2013, 397, 1, 13),
('Michael Schumacher', 'Ferrari', 2004, 148, 1, 13),
('Nico Rosberg', 'Mercedes', 2016, 385, 1, 9),
('Jenson Button', 'Brawn GP', 2009, 95, 1, 6),
('Kimi Raikkonen', 'Ferrari', 2007, 110, 1, 6);

select * from f1_drivers;
select * from f1_teams;
select * from f1_results_history;

# Beginner
#Q1.) The "Legendary" Filter: Write a query to find all active drivers who have won at least one Championship. Sort the results by the number of Championships in descending order.
SELECT 
    driver, Championships
FROM
    f1_drivers
WHERE
    Active = 1
ORDER BY Championships DESC;

#Q2.) Nationality Insights: Which country has produced the most Formula 1 drivers? List the Nationality and the total count of drivers for each, but only include nationalities with more than 5 drivers.
SELECT 
    Nationality, COUNT(*) AS Total_Drivers
FROM
    f1_drivers
GROUP BY Nationality
HAVING COUNT(*) > 5
ORDER BY Total_Drivers DESC;

#Q3.) Efficiency Check: List the top 10 drivers with the highest Win_Rate. Include their Driver name and Race_Wins.
SELECT 
    Driver, race_wins, win_rate
FROM
    f1_drivers
ORDER BY Win_Rate DESC
LIMIT 10;

#Q4.) Decade Summary: For each Decade, calculate the total Race_Entries and the average Points earned by drivers in that decade.
SELECT 
    decade,
    AVG(points) AS avg_points_PerDriver,
    SUM(Race_Entries) AS Total_Race_Entries
FROM
    f1_drivers
GROUP BY decade;




# Intermediate

#Q5.) Performance Categorization: Create a report that classifies drivers into three categories: 'Elite' (more than 20 wins), 'Veteran' (between 5 and 20 wins), and 'Contender' (less than 5 wins). Display the Driver name and their Status.
SELECT Driver,
    CASE 
        WHEN Race_Wins > 20 THEN 'Elite'
        WHEN Race_Wins BETWEEN 5 AND 20 THEN 'Veteran'
        ELSE 'Contender'
    END AS Status
FROM 
    f1_drivers
ORDER BY 
    Race_Wins DESC;

#Q6) The "Uncrowned Kings": Find the top 5 drivers who have the highest number of Podiums but have never won a Championship.
select driver,podiums from f1_drivers
where Championships=0
order by podiums desc
limit 5;

#Q7) Active vs. Retired Comparison: Use a single query to find the average Win_Rate for Active drivers versus retired drivers. (Hint: Use GROUP BY Active).
SELECT 
    Active,
    AVG(Win_Rate) AS Average_Win_Rate
FROM 
    f1_drivers
GROUP BY 
    Active;

#Q8) Consistency Medal: Identify drivers whose Podium_Rate is higher than the average Podium_Rate of all drivers in the dataset.
SELECT 
    Driver, 
    Podium_Rate
FROM 
    f1_drivers
WHERE 
    Podium_Rate > (SELECT AVG(Podium_Rate) FROM f1_drivers)
ORDER BY 
    Podium_Rate DESC;

#Advance
#Q9) National Rankings: Rank drivers within their own Nationality based on their total Points. Use a window function to show the driver's rank alongside their name and country.
SELECT 
    Driver,
    Nationality,
    Points,
    RANK() OVER (PARTITION BY Nationality ORDER BY Points DESC) AS National_Rank
FROM 
    f1_drivers;

#Q10) Decade Dominance: Using a CTE, find the driver in each Decade who had the highest Race_Wins. Your output should show the Decade, Driver, and Race_Wins.
WITH DecadeRankings AS (
    SELECT 
        Decade,
        Driver,
        Race_Wins,
        RANK() OVER (PARTITION BY Decade ORDER BY Race_Wins DESC) AS win_rank
    FROM 
        f1_drivers
)
SELECT 
    Decade, 
    Driver, 
    Race_Wins
FROM 
    DecadeRankings
WHERE 
    win_rank = 1
ORDER BY 
    Decade DESC;

#Q11) Points Contribution: Calculate the percentage of total points contributed by each driver relative to all other drivers of the same Nationality.
SELECT 
    Driver,
    Nationality,
    Points,
    (Points / SUM(Points) OVER (PARTITION BY Nationality)) * 100 AS Points_Contribution_Percentage
FROM 
    f1_drivers
ORDER BY 
    Nationality, 
    Points_Contribution_Percentage DESC;

#Q12) The Career Longevity Peak: Find the drivers who have been active for more than 10 years (Years_Active) and identify those who maintained a Points_Per_Entry higher than 5.0 throughout their career.
SELECT 
    Driver, 
    Years_Active, 
    Points_Per_Entry
FROM 
    f1_drivers
WHERE 
    Years_Active > 10 
    AND Points_Per_Entry > 5.0
ORDER BY 
    Points_Per_Entry DESC;

# Joins questions
#Q13.) The "Championship Efficiency" Index
#Goal: Compare a driver's career-wide winning percentage against their specific performance for their 2025 team.
#Question: Write a query that joins f1_drivers and f1_results_history to list all 2025 drivers. Display their Driver name, their career Win_Rate (from the drivers table), and their 2025-specific Win Rate (calculated as Wins_That_Season / 20 assuming a 20-race season).
SELECT 
    d.Driver, 
    d.Win_Rate AS Career_Win_Rate, 
    (h.Wins_That_Season / 20.0) AS Season_2025_Win_Rate
FROM 
    f1_drivers d
JOIN 
    f1_results_history h ON d.Driver = h.Driver_Name
WHERE 
    h.Season_Year = 2025;


#Q14.) Constructor Factory Dominance
#Goal: Analyze which team's headquarters has produced the most successful "Season Wins."
#Question: Join f1_teams and f1_results_history to find the total Wins_That_Season grouped by Base_Location. Your result should show the city, the team name, and the sum of wins. Only include locations that have a total of more than 10 wins across all recorded history.
SELECT 
    t.Base_Location, 
    t.Team_Name, 
    SUM(h.Wins_That_Season) AS Total_Wins
FROM 
    f1_teams t
JOIN 
    f1_results_history h ON t.Team_Name = h.Team_Name
GROUP BY 
    t.Base_Location, 
    t.Team_Name
HAVING 
    SUM(h.Wins_That_Season) > 10
ORDER BY 
    Total_Wins DESC;


#Q15.) The "Rookie vs. Legend" Benchmarking (Self-Join + CTE)
#Goal: Use a Common Table Expression to compare 2025 rookies against historical champions.
#Question: Create a CTE that identifies all drivers in f1_results_history with Season_Rank = 1 (Champions). Then, write a main query that joins this CTE with the 2025 grid data to find any 2025 driver who scored more Season_Points than a historical champion did in their winning year (e.g., comparing Norris 2025 to Schumacher 2004).
WITH HistoricalChampions AS (
    -- Step 1: Identify all historical drivers who finished Rank 1
    SELECT 
        Driver_Name AS Champion_Name, 
        Season_Year AS Title_Year, 
        Season_Points AS Title_Points
    FROM 
        f1_results_history
    WHERE 
        Season_Rank = 1
)
-- Step 2: Join the 2025 grid against the CTE to find higher point scores
SELECT 
    grid.Driver_Name AS Driver_2025,
    grid.Season_Points AS Points_2025,
    hc.Champion_Name AS Historical_Champion,
    hc.Title_Year,
    hc.Title_Points AS Champion_Winning_Points
FROM 
    f1_results_history AS grid
JOIN 
    HistoricalChampions AS hc ON grid.Season_Points > hc.Title_Points
WHERE 
    grid.Season_Year = 2025
ORDER BY 
    grid.Season_Points DESC, hc.Title_Points DESC;


#Q16.) The Engine Supplier Market Share
#Goal: Determine which engine manufacturer is currently providing the best "Value for Points."
#Question: Join all three tables (f1_drivers, f1_teams, and f1_results_history). Calculate the Average Points per Driver for each Engine_Supplier in the 2025 season. Rank the engine suppliers from 1 to N based on this average using a RANK() or DENSE_RANK() window function.
SELECT 
    t.Engine_Supplier,
    AVG(h.Season_Points) AS Average_Points_Per_Driver,
    RANK() OVER (ORDER BY AVG(h.Season_Points) DESC) AS Supplier_Rank
FROM 
    f1_results_history h
JOIN 
    f1_teams t ON h.Team_Name = t.Team_Name
JOIN 
    f1_drivers d ON h.Driver_Name = d.Driver
WHERE 
    h.Season_Year = 2025
GROUP BY 
    t.Engine_Supplier;