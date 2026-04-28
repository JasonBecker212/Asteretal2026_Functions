%finds the L_1 linear fit that goes through the first data point
function [a,b] = robustfit0(x,y)
    x = x(:); y = y(:);
    x1 = x(1); y1 = y(1);
    d  = x - x1;
    m  = d ~= 0;                 % ignore points with x==x1; they don't influence b
    z  = (y(m) - y1) ./ d(m);    % candidate slopes
    w  = abs(d(m));              % weights

    b = weightedMedian(z, w);    % argmin_b sum_i w_i |z_i - b|
    a = y1 - b*x1;               % intercept so the line hits (x1,y1)
end

function m = weightedMedian(z,w)
    [zs,idx] = sort(z);
    ws = w(idx);
    c = cumsum(ws) / sum(ws);
    k = find(c >= 0.5, 1, 'first');
    m = zs(k);
end