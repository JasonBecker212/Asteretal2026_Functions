%movmedian with nan masking from original time series
function y = movmedian2(x,m)

y=movmedian(x,m,'omitmissing');
y(isnan(x))=NaN;
return