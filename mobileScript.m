% Delete existing csv file to start
filename = "C:\\Users\\thisuaser\\Desktop\\csvOutput.csv";
delete(filename);

% write headers on csv file
fileId = fopen (filename, "w");
fdisp(fileId, strcat("Date,Time,Force"));
fclose (fileId);

% Read and display the data file one line at a time:
fid = fopen('C:\\Users\\thisuser\\Desktop\\Mobile Data\\20220118154359_fe.log');
tline = fgetl(fid);

% Pattern we're looking for
pattern = '[angle  ]:error:AngleMgr:Fall!';

% read each line and check for pattern
while ischar(tline)
    
    % does line have force report?
    if ismember(pattern, tline)
      % Get relevant info
      dateOfFall = substr(tline, 2, 11);
      timeOfFall = substr(tline, 13, 5);
      lastSpaceIndex = rindex(tline, " ");
      gIndex = index(tline, "[g]") - 1;
      forceOfFall = substr(tline, lastSpaceIndex + 1, gIndex - lastSpaceIndex);

      % write to csv file
      fileId = fopen (filename, "a");
      fdisp(fileId, strcat(dateOfFall, ",", timeOfFall, ",", forceOfFall));
      fclose (fileId);
    end
    
    tline = fgetl(fid);

end
fclose(fid);
