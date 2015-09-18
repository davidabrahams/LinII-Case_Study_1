% This is our objective function. Each row is a source, each column a town.
% Covert the objective function to a column vector.
Objective = [450, 460, 440, 445, 455;
             495, 500, 505, 510, 490;
             900, 915, 885, 920, 920;
             1800, 1815, 1795, 1785, 1820];
Objective = Objective';
Objective = Objective(:)';

% The maximum amount of water each source can supply
Supply_Maxes = [15; 10; 60; 80];

% This matrix, when multipl ied by a column vector containing the amount of
% water each source supplies to each town, returns a column vector for how
% much water each supply gave off.
Total_Supply_Usage = zeros(4, 20);
for i=1:4
    
    Total_Supply_Usage(i, (5*i - 4) : (5*i)) = 1;
    
end

% The amount of water each town needs
City_Needs = [30; 10; 50; 20; 40];

% This matrix, when multiplied by the column vector, gives the total amount
% of water each town recieved.
Total_City_Water = zeros(5, 20);
for i=1:5
    Total_City_Water(i, i:5:20) = 1;
end

% This is the total amount of hardness each city can have. It is the
% hardness per Ml times the amount of water each city needs, in Ml
Hardness_Maxes = [1200; 1200; 1200; 1200; 1200] .* City_Needs;


% This matrix, when multiplied by the column vector, gives the total amount
% of hardness each town recieved.
Supply_Hardness = [250, 200, 2300, 700];
Hardness_Matrix = zeros(5, 20);
for i=1:5
    Hardness_Matrix(i, i:5:20) = Supply_Hardness;
end

% A vertical combination of Water Use and Hardness, both <= constraints
Usage_and_Hardness = vertcat(Total_Supply_Usage, Hardness_Matrix);
Supply_Hard_Max = vertcat(Supply_Maxes, Hardness_Maxes);

% Each city has to give at least 0 water.
for i=1:20
    minimum(i, 1) = 0;
end

% Get the optimal solution
x = linprog(Objective, Usage_and_Hardness, Supply_Hard_Max,...
    Total_City_Water, City_Needs, minimum, []);
% Convert to a 4x5 matrix and print it
for i=1:4
    result(i, 1:5) = x(5*i - 4:5*i, 1);
end
disp(result);

