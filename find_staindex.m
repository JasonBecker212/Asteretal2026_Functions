function stindex=find_staindex(station_list,station)
stindex=find(~cellfun(@isempty,strfind(station_list,station)));