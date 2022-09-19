clear all; close all;

basedir = 'files/';

filelist = dir(fullfile(basedir, '**\*.csv'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list

fid = fopen('obs_maps.csv','wt');

for i = 1:length(filelist)
    fid1 = fopen([filelist(i).folder,'\',filelist(i).name],'rt');
    fline = fgetl(fid1);
    if i == 1
        fprintf(fid,'%s\n',fline);
    end
    
    while ~feof(fid1)
        fline = fgetl(fid1);
        fprintf(fid,'%s\n',fline);
    end
    fclose(fid1);
end
        
        