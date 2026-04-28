function ind=get_start_date_index(st_name,dates_sort)

ind=0;

if strcmp(st_name,'LVZ')
    ind=find(dates_sort<datenum(1994,5,24));
    return
end

if strcmp(st_name,'RPN')
    ind=find(dates_sort<datenum(2001,9,1));
    return
end

if strcmp(st_name,'TUC')
    ind=find(dates_sort<datenum(2001,9,1));
    return
end

if strcmp(st_name,'PFO')
    ind=find(dates_sort<datenum(1992,1,1));
    return
end

if strcmp(st_name,'HKT')
    ind=find(dates_sort<datenum(2002,9,1));
    return
end

if strcmp(st_name,'CRZF')
    ind=find(dates_sort<datenum(1999,1,1));
    return
end

if strcmp(st_name,'DRV')
    ind=find(dates_sort<datenum(1991,7,1));
    return
end

if strcmp(st_name,'HDC')
    ind=find(dates_sort<datenum(2002,6,30));
    return
end

if strcmp(st_name,'RER')
    ind=find(dates_sort<datenum(2004,10,7));
    return
end

if strcmp(st_name,'MIDW')
    ind=find(dates_sort<datenum(2004,1,12));
    return
end

if strcmp(st_name,'TAU')
    ind=find(dates_sort<datenum(1996,1,29));
return
end

if strcmp(st_name,'KIP')
    ind=find(dates_sort<datenum(1998,10,14));
return
end

return
