function out = l1_line_fit_xyerr(x, y, sx, sy, varargin)
% L1 linear regression with errors in x and y using orthogonal |residual| loss.
% Minimizes sum_i | y_i - (a + b x_i) | / sqrt( b^2*sx_i^2 + sy_i^2 )
% Returns bootstrap SEs for intercept (a) and slope (b).
%
% Usage:
% out = l1_line_fit_xyerr(x, y, sx, sy);
% out = l1_line_fit_xyerr(x, y, sx, sy, struct('nboot',1500,'seed',1));
% out = l1_line_fit_xyerr(x, y, sx, sy, 'nboot',1500, 'bootstrap','pairs');
% ---------- parse inputs ----------
if ~isvector(x) || ~isvector(y) || ~isvector(sx) || ~isvector(sy)
    error('x, y, sx, sy must be vectors of the same length.');
end
x=x(:); y=y(:); sx=sx(:); sy=sy(:);
n=numel(x);
if any([numel(y),numel(sx),numel(sy)]~=n)
    error('x, y, sx, sy must have equal length.');
end
good = isfinite(x)&isfinite(y)&isfinite(sx)&isfinite(sy);
x=x(good); y=y(good); sx=sx(good); sy=sy(good);
n=numel(x);
if n<2, error('Need at least two finite data points.'); end
% Defaults
opts = struct('nboot',10000,'bootstrap','parametric', ...
    'seed',[],'maxfun',2e5,'maxiter',2e5);
% struct or name-values
if ~isempty(varargin)
    if isstruct(varargin{1})
        S = varargin{1};
        f = fieldnames(S);
        for k=1:numel(f), opts.(f{k}) = S.(f{k}); end
        varargin(1) = [];
    end
    if ~isempty(varargin)
        if mod(numel(varargin),2)~=0
            error('Name-value pairs must come in pairs.');
        end
        for k=1:2:numel(varargin)
            opts.(lower(varargin{k})) = varargin{k+1};
        end
    end
end
opts.bootstrap = string(lower(opts.bootstrap));
if ~(opts.bootstrap=="parametric" || opts.bootstrap=="pairs")
    error('bootstrap must be ''parametric'' or ''pairs''.');
end
if ~isempty(opts.seed), rng(opts.seed); end
% ---------- initial guess (OLS) ----------
xm = mean(x); ym = mean(y);
Sxx = sum((x-xm).^2); Sxy = sum((x-xm).*(y-ym));
b0 = (Sxx==0) * 0 + (Sxx~=0) * (Sxy/Sxx);
a0 = ym - b0*xm;
% ---------- objective & optimizer ----------
objfun = @(p) sum_abs_orth(p, x, y, sx, sy);
% *** FIXED: do NOT mix 'fminsearch' token with name-value pairs ***
nm = optimset('MaxFunEvals',opts.maxfun, ...
    'MaxIter',opts.maxiter, ...
    'TolX',1e-10,'TolFun',1e-10,'Display','off');
[p_hat, fval, exitflag] = fminsearch(objfun, [a0, b0], nm);
a = p_hat(1); b = p_hat(2);
% ---------- bootstrap ----------
a_boot = NaN(opts.nboot,1);
b_boot = NaN(opts.nboot,1);
switch opts.bootstrap
    case "parametric"
        for k=1:opts.nboot
            xk = x + sx.*randn(n,1);
            yk = y + sy.*randn(n,1);
            [ak,bk] = fit_once([a,b], xk, yk, sx, sy, nm);
            a_boot(k)=ak; b_boot(k)=bk;
        end
    case "pairs"
        for k=1:opts.nboot
            idx = randsample(n,n,true);
            [ak,bk] = fit_once([a,b], x(idx), y(idx), sx(idx), sy(idx), nm);
            a_boot(k)=ak; b_boot(k)=bk;
        end
end
se_a = std(a_boot,0,1,'omitnan');
se_b = std(b_boot,0,1,'omitnan');
ci_a = qtiles(a_boot,[0.025 0.975]);
ci_b = qtiles(b_boot,[0.025 0.975]);
out = struct('a',a,'b',b, ...
    'se_a',se_a,'se_b',se_b, ...
    'ci_a',ci_a,'ci_b',ci_b, ...
    'obj',fval,'converged',exitflag>0, ...
    'method','L1 orthogonal with heteroscedastic xy-errors', ...
    'details',struct('bootstrap',opts.bootstrap,'nboot',opts.nboot, ...
    'exitflag',exitflag,'a_boot',a_boot,'b_boot',b_boot, ...
    'options',opts));
end
% ---- helpers -------------------------------------------------------------
function S = sum_abs_orth(p, x, y, sx, sy)
a = p(1); b = p(2);
num = abs(y - (a + b*x));
den = sqrt(max(b.^2 .* sx.^2 + sy.^2, eps));
S = sum(num ./ den);
if ~isfinite(S), S = realmax/10; end
end
function [a_hat,b_hat] = fit_once(p0, x, y, sx, sy, nm)
if any(~isfinite(p0)), p0=[median(y),0]; end
obj = @(pp) sum_abs_orth(pp, x, y, sx, sy);
p = fminsearch(obj, p0, nm);
a_hat = p(1); b_hat = p(2);
end
function q = qtiles(v,p)
% percentile helper (works if QUANTILE is missing)
if exist('quantile','builtin') || exist('quantile','file')
    q = quantile(v,p);
else
    q = prctile(v,100*p);
end
end