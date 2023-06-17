function [cA, cellArray] = MultiModalTestScript(filePath)
% Specify the path and filename of the Excel file
excelFile = filePath;

% Initialize an empty cell array to store the data from each sheet
allData = cell(1, 11);

% Loop through the sheets
for sheetIndex = 1:11
    % Read the data from the current sheet
    sheetData = readtable(excelFile, 'Sheet', sheetIndex);
    
    % Store the sheet data in the cell array
    allData{sheetIndex} = sheetData;
end

% Concatenate the sheets together
combinedData = vertcat(allData{:});
cA = table2cell(combinedData);
cA = [cA, cell(size(cA, 1), 2)];
numRows = size(cA, 1);
observed = 0;
total = 0;

for i=1:numRows
    if ~isnan(cA{i, 4})
        observed = observed + cA{i, 4};
        total = total + 1;
    else
        cA{i, 5} = observed;
        cA{i, 6} = (observed/total) * 100;
        observed = 0;
        total = 0;
    end
end

% Display the combined data%function [matrix1] = MultiModalTestScript(filePath)
disp(cA);






sheets = sheetnames(excelFile);
arrayLength = length(sheets);
cellArray = cell(11, 4);

for i = 1:arrayLength
    cellArray{i,1} = sheets{i};
end

j = 1;
for i=1:numRows
    if isnan(cA{i, 4})
        cellArray{j, 2} = cA{i, 5};
        cellArray{j, 3} = cA{i, 6};
        j = j + 1;
    end
end

min = cellArray{1, 3};
max = cellArray{1, 3};
for i = 1:11
    if (cellArray{i, 3} > max)
        max = cellArray{i, 3};
    end
    if (cellArray{i, 3} < min)
        min = cellArray{i, 3};
    end
end



for i = 1:11
    if (cellArray{i, 3} == max)
        cellArray{i, 4} = 1;
    end
    if (cellArray{i, 3} == min)
        cellArray{i, 4} = 0;
    end
end

% Display the cell array
disp(cellArray);






function cell2csv(filename, cellArray, delimiter)
    % Open the file for writing
    fileID = fopen(filename, 'w');

    % Loop through the rows of the cell array
    for row = 1:size(cellArray, 1)
        % Convert the current row to a comma-separated string
        rowStr = cellArray{row, 1};
        for col = 2:size(cellArray, 2)
            rowStr = [rowStr delimiter cellArray{row, col}];
        end

        % Write the row string to the file
        fprintf(fileID, '%s\n', rowStr);
    end

    % Close the file
    fclose(fileID);
end






cell2csv('Matrix1.csv', cA, ',');
cell2csv('Matrix2.csv', cellArray, ',');


disp('CSV files created successfully.');

end

