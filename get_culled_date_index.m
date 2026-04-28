function ind=get_culled_date_index(st_name,dates_sort)
ind=[];

if strcmp(st_name,'DGAR')
    ind=find(dates_sort>datenum(2007,12,10) & dates_sort <=datenum(2008,2,20));
    ind=[ind;find(dates_sort>datenum(2024,8,1))];
return
end

if strcmp(st_name,'KMI')
    ind=find(dates_sort>datenum(2024,5,24) & dates_sort <=datenum(2025,9,26));
return
end

if strcmp(st_name,'BORG')
    ind=find(dates_sort>datenum(1996,11,28) & dates_sort <=datenum(1999,8,6));
return
end

if strcmp(st_name,'CASY')
    ind=find(dates_sort>datenum(1998,12,11) & dates_sort <=datenum(1999,4,25));
    ind=[ind;find(dates_sort>datenum(1999,11,20) & dates_sort<datenum(2000,4,10))];
    ind=[ind;find(dates_sort>datenum(2000,11,14) & dates_sort<datenum(2001,4,20))];
    ind=[ind;find(dates_sort>datenum(1997,12,13) & dates_sort<datenum(1998,4,19))];
    ind=[ind;find(dates_sort>datenum(1996,12,6) & dates_sort<datenum(1997,4,13))];
return
end

if strcmp(st_name,'CMLA')
    ind=find(dates_sort>datenum(2005,7,28) & dates_sort <=datenum(2006,8,28));
return
end

if strcmp(st_name,'GRFO')
    ind=find(dates_sort>datenum(1997,1,1) & dates_sort <=datenum(1998,3,1));
return
end

if strcmp(st_name,'YSS')
    ind=find(dates_sort>datenum(2006,7,26) & dates_sort <=datenum(2010,11,24));
return
end

if strcmp(st_name,'FURI')
    ind=find(dates_sort>datenum(2007,1,3) & dates_sort<datenum(2008,4,8));
    ind=[ind;find(dates_sort>datenum(2009,9,15) & dates_sort<datenum(2009,11,3))];
    ind=[ind;find(dates_sort>datenum(2007,8,12) & dates_sort<datenum(2007,8,23))];
    ind=[ind;find(dates_sort>datenum(2019,6,23) & dates_sort<datenum(2007,9,27))];
    ind=[ind;find(dates_sort>datenum(2009,9,8) & dates_sort<datenum(2009,9,11))];
return
end

if strcmp(st_name,'ABPO')
    ind=find(dates_sort>datenum(2015,10,2) & dates_sort<datenum(2015,12,17));
return
end



if strcmp(st_name,'POHA')
    ind=find(dates_sort>datenum(2009,1,1) & dates_sort<datenum(2013,1,1));
return
end

if strcmp(st_name,'PAYG')
    ind=find(dates_sort>datenum(2018,12,1) & dates_sort<datenum(2019,9,26));
return
end

if strcmp(st_name,'CHTO')
    ind=find(dates_sort>datenum(2006,2,1) & dates_sort<datenum(2006,5,1));
    ind=[ind;find(dates_sort>datenum(2016,10,15) & dates_sort<datenum(2019,3,1))];
    ind=[ind;find(dates_sort>datenum(2022,11,12) & dates_sort<datenum(2023,2,15))];
return
end

if strcmp(st_name,'DWPF')
    ind=find(dates_sort>datenum(2009,4,16) & dates_sort<datenum(2009,7,20));
    ind=[ind;find(dates_sort>datenum(2009,8,27) & dates_sort<datenum(2010,7,19))];
return
end

if strcmp(st_name,'PTCN')
    ind=find(dates_sort>datenum(2008,4,4) & dates_sort<datenum(2008,7,8));
    ind=[ind;find(dates_sort>datenum(2005,11,9) & dates_sort<datenum(2005,12,24))];
    ind=[ind;find(dates_sort>datenum(2012,4,17) & dates_sort<datenum(2012,8,25))];
return
end

if strcmp(st_name,'DAV')
    ind=find(dates_sort>datenum(2000,1,1) & dates_sort<datenum(2007,1,1));
    ind=[ind;find(dates_sort>datenum(2015,6,1) & dates_sort<datenum(2015,10,1))];
return
end

if strcmp(st_name,'NWAO')
    ind=find(dates_sort>datenum(2009,11,5) & dates_sort<datenum(2010,9,25));
return
end

if strcmp(st_name,'WRAB')
    ind=find(dates_sort>datenum(1996,11,1) & dates_sort<datenum(1997,2,1));
return
end

if strcmp(st_name,'RAR')
    ind=find(dates_sort>datenum(2005,8,31) & dates_sort<datenum(2007,9,15));
    ind=[ind;find(dates_sort>datenum(2010,5,3) & dates_sort<datenum(2010,12,19))];
return
end

if strcmp(st_name,'MIDW')
    ind=find(dates_sort>datenum(1999,10,1) & dates_sort<datenum(2004,1,1));
    ind=[ind;find(dates_sort>datenum(2019,11,26) & dates_sort<datenum(2019,12,6))];
return
end

if strcmp(st_name,'COLA')
    ind=find(dates_sort>datenum(2005,6,1) & dates_sort<datenum(2005,10,1));
return
end

if strcmp(st_name,'COR')
    ind=find(dates_sort>datenum(2000,7,1) & dates_sort<datenum(2002,4,1));
return
end

if strcmp(st_name,'TATO')
    ind=find(dates_sort<datenum(1993,7,1));
return
end

if strcmp(st_name,'SJG')
    ind=find(dates_sort>datenum(2007,11,1) & dates_sort<datenum(2008,6,7));
return
end

if strcmp(st_name,'SNZO')
    ind=find(dates_sort>datenum(2002,7,22) & dates_sort<datenum(2003,1,27));
return
end

if strcmp(st_name,'SSPA')
    ind=find(dates_sort>datenum(1996,4,14) & dates_sort<datenum(1996,11,3));
    ind=[ind;find(dates_sort>datenum(1995,6,15) & dates_sort<datenum(1995,9,22))];
return
end

if strcmp(st_name,'RSSD')
    ind=find(dates_sort>datenum(2006,12,1) & dates_sort<datenum(2007,5,1));
    ind=[ind;find(dates_sort>datenum(2004,10,20) & dates_sort<datenum(2007,10,19))];
return
end

if strcmp(st_name,'INCN')
    ind=find(dates_sort>datenum(2010,8,1) & dates_sort<datenum(2011,12,1));
    ind=[ind;find(dates_sort>datenum(2011,8,1) & dates_sort<datenum(2011,12,1))];
return
end

if strcmp(st_name,'INU')
    ind=find(dates_sort>datenum(2007,6,22) & dates_sort<datenum(2011,10,26));
return
end

if strcmp(st_name,'LCO')
    ind=find(dates_sort>datenum(2014,11,1) & dates_sort<datenum(2014,12,15));
return
end

if strcmp(st_name,'GUMO')
    ind=find(dates_sort>datenum(2006,5,3) & dates_sort<datenum(2006,9,20));
    ind=[ind;find(dates_sort>datenum(2004,12,22)& dates_sort<datenum(2005,9,6))];
    ind=[ind;find(dates_sort>datenum(2017,10,18)& dates_sort<datenum(2017,10,27))];
    ind=[ind;find(dates_sort<datenum(1991,9,22))];
    ind=[ind;find(dates_sort>datenum(1992,8,7)& dates_sort<datenum(1993,1,27))];
return
end

if strcmp(st_name,'HDC')
    ind=find(dates_sort>datenum(2017,11,2) & dates_sort<datenum(2018,4,10));
    ind=[ind;find(dates_sort>datenum(2013,10,12)& dates_sort<datenum(2013,11,15))];
    ind=[ind;find(dates_sort>datenum(2014,3,25)& dates_sort<datenum(2014,6,7))];
return
end

if strcmp(st_name,'UNM')
    ind=find(dates_sort>datenum(1998,10,2) & dates_sort<datenum(2002,12,7));
    ind=[ind;find(dates_sort>datenum(2012,4,19) & dates_sort<datenum(2012,7,17))];
return
end

if strcmp(st_name,'DRV')
    ind=find(dates_sort>datenum(2012,11,5) & dates_sort<datenum(2015,9,25));
return
end

if strcmp(st_name,'ENH')
    ind=find(dates_sort>datenum(2017,6,26) & dates_sort<datenum(2017,12,16));
    ind=[ind;find(dates_sort>datenum(2024,4,13) & dates_sort<datenum(2025,1,1))];
return
end

if strcmp(st_name,'XAN')
    ind=find(dates_sort>datenum(2022,2,14) & dates_sort<datenum(2022,4,6));
    ind=[ind;find(dates_sort>datenum(2008,2,24) & dates_sort<datenum(2010,7,28))];
return
end

if strcmp(st_name,'QIZ')
    ind=find(dates_sort>datenum(2013,9,27) & dates_sort<datenum(2013,11,6));
    ind=[ind;find(dates_sort>datenum(2008,2,24) & dates_sort<datenum(2008,6,29))];
return
end

if strcmp(st_name,'BBSR')
 ind=find(dates_sort>datenum(2009,5,1) & dates_sort<datenum(2009,5,22));
 ind=[ind;find(dates_sort>datenum(2011,4,24) & dates_sort<datenum(2012,9,11))];
return
end

if strcmp(st_name,'BJT')
    ind=find(dates_sort>datenum(2005,5,21) & dates_sort<datenum(2011,5,6));
    ind=[ind;find(dates_sort>datenum(2011,5,7) & dates_sort<datenum(2012,9,11))];
return
end

if strcmp(st_name,'CCM')
    ind=find(dates_sort>datenum(1996,2,14) & dates_sort<datenum(1996,6,1));
    ind=[ind;find(dates_sort>datenum(2009,1,12) & dates_sort<datenum(2011,7,29))];
return
end

if strcmp(st_name,'KURK')
    ind=find(dates_sort>datenum(1996,6,4) & dates_sort<datenum(1997,4,13));
    ind=[ind;find(dates_sort>datenum(2009,1,12) & dates_sort<datenum(2011,7,29))];
return
end

if strcmp(st_name,'NOUC')
    ind=find(dates_sort>datenum(1991,10,28) & dates_sort<datenum(1992,7,2));
    ind=[ind;find(dates_sort>datenum(2009,1,12) & dates_sort<datenum(2011,7,29))];
return
end

if strcmp(st_name,'KIV')
    ind=find(dates_sort>datenum(2013,3,9) & dates_sort<datenum(2016,12,27));
    ind=[ind;find(dates_sort>datenum(2009,1,12) & dates_sort<datenum(2011,7,29))];
return
end

if strcmp(st_name,'TSUM')
    ind=find(dates_sort>datenum(2002,12,23) & dates_sort<datenum(2003,5,29));
return
end

if strcmp(st_name,'WVT')
    ind=find(dates_sort>datenum(2014,8,21) & dates_sort<datenum(2014,9,30));
    ind=[ind;find(dates_sort>datenum(1997,10,30) & dates_sort<datenum(1998,5,20))];
return
end

if strcmp(st_name,'FDF')
    ind=find(dates_sort>datenum(2004,2,9) & dates_sort <=datenum(2004,8,20));
return
end

return
