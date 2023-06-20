function [data] = MultiModalTestScriptFR(filePath)
% Read the text file
fileID = fopen(filePath, 'r');
fileData = fscanf(fileID, '%c');
fclose(fileID);

% Extract facial recognition data and key presses
matches = regexp(fileData, 'Key Pressed:\s*(\w)', 'match');
matches2 = regexp(fileData, 'FR Image: FR1/(\w+)', 'match');

% Create the cell array to store the matched data
matchedData = cell(length(matches), 2);

% Iterate over matches and populate the matchedData cell array
for i = 1:length(matches)
    key = strrep(matches{i}, "Key Pressed: ", "");
    name = strrep(matches2{i}, "FR Image: FR1/FR1_", "");
    matchedData{i, 2} = key;
    matchedData{i, 1} = name;
end

% Create the data cell array with header
data = [{"Facial Recognition Image", "Key Pressed"}; matchedData];

% Display the data cell array
disp(data);

end
