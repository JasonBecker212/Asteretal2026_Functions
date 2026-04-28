%rounds time to the nearest 30 minutes
function datetime30=datetime_round30(dtime)
for i=1:length(dtime)
    tt.mm=dtime(i);
    x=round(tt.mm.Minute/30)*30;
    tt.mm.Minute=x;
    tt.mm.Second=0;
    dtime(i)=tt.mm;
end
datetime30=dtime;
