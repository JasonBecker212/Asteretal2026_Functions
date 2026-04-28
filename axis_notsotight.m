%invoke after "axis tight" to slightly expand the axes by axfactor
function axis_notsotight(axlim,axfactor)
axlims=eval(axlim);
lim_mean=mean(axlims);
%[axlim,'(',num2str(axfactor),'*([',num2str(axlims(1)),' ',num2str(axlims(2)),']-',num2str(lim_mean),')+',num2str(lim_mean),')']
eval([axlim,'(',num2str(axfactor),'*([',num2str(axlims(1)),' ',num2str(axlims(2)),']-',num2str(lim_mean),')+',num2str(lim_mean),')']);