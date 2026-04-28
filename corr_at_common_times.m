function [r, n, out] = corr_at_common_times(x, t1, y, t2, tol)
% corr_at_common_times  Correlate two time series using only common times.
%
% USAGE:
%   [r, n, out] = corr_at_common_times(x, t1, y, t2)
%   [r, n, out] = corr_at_common_times(x, t1, y, t2, tol)
%
% INPUTS:
%   x   - numeric vector of series-1 values (length(t1) elements)
%   t1  - time index for x; numeric, datetime, or duration
%   y   - numeric vector of series-2 values (length(t2) elements)
%   t2  - time index for y; numeric, datetime, or duration
%   tol - (optional) nonnegative scalar tolerance for time matching.
%         Units follow the time representation:
%           * numeric times: same units as t1/t2 values
%           * datetime: seconds
%           * duration: seconds
%         Default: 0 (exact timestamp matches required)
%
% OUTPUTS:
%   r   - Pearson correlation coefficient between aligned x and y
%   n   - number of overlapping points used to compute r
%   out - table with columns:
%           time  : common times (in the same class as inputs)
%           x     : x values at those times
%           y     : y values at those times
%
% NOTES:
%   - If timestamps are not exactly equal but within 'tol', they are
%     snapped to a common grid (via rounding) before intersection.
%   - If duplicate timestamps exist within a series (after snapping),
%     values at duplicates are averaged before alignment.
%   - If fewer than two common points exist, r = NaN and n < 2.
%
% EXAMPLE:
%   t1 = datetime(2025,1,1,0,0,0) + minutes(0:10:120);
%   t2 = datetime(2025,1,1,0,5,0) + minutes(0:10:120);
%   x  = sin(0.1*(0:numel(t1)-1)) + 0.05*randn(size(t1));
%   y  = sin(0.1*(0:numel(t2)-1)) + 0.05*randn(size(t2));
%   [r, n, out] = corr_at_common_times(x,t1,y,t2,seconds(60));  % 60 s tol
%   % r is the correlation on overlapping times (within 1 minute)
%
% R. Aster (CSU) — utility function for aligning and correlating time series

    narginchk(4,5);
    if nargin < 5 || isempty(tol); tol = 0; end

    % basic checks
    validateattributes(x,  {'numeric'}, {'vector','real','numel',numel(x)});
    validateattributes(y,  {'numeric'}, {'vector','real','numel',numel(y)});
    if numel(t1) ~= numel(x), error('Length(t1) must equal length(x).'); end
    if numel(t2) ~= numel(y), error('Length(t2) must equal length(y).'); end

    % unify time types and convert to a numeric axis for matching
    [tclass, t1n, t2n, tol_sec] = normalize_time_axes(t1, t2, tol);

    % snap times to a common grid if tolerance > 0 (round-to-nearest)
    if tol_sec > 0
        g1 = round(t1n / tol_sec);
        g2 = round(t2n / tol_sec);
        % reduce duplicates by averaging values at identical snapped bins
        [g1u, xu] = reduce_duplicates(g1, x);
        [g2u, yu] = reduce_duplicates(g2, y);
        % intersect on snapped bins
        [gC, ia, ib] = intersect(g1u, g2u, 'stable');
        xc = xu(ia);
        yc = yu(ib);
        % map common snapped bins back to a representative time axis
        tn_num = gC * tol_sec;
    else
        % exact matching
        [tC, ia, ib] = intersect(t1n, t2n, 'stable');
        xc = x(ia);
        yc = y(ib);
        tn_num = tC;
    end

    % cast numeric time back to original class for output table
    t_out = cast_back_time(tn_num, tclass);

    % build output table & compute correlation
    out = table(t_out(:), xc(:), yc(:), 'VariableNames', {'time','x','y'});
    n = height(out);
    if n < 2
        r = NaN;
        return;
    end

    C = corrcoef(xc, yc);   % base MATLAB
    r = C(1,2);
end

% --- helpers ---

function [tclass, t1n, t2n, tol_sec] = normalize_time_axes(t1, t2, tol)
% Convert time vectors to a common numeric axis (seconds) for matching.
% Returns class name of original inputs (must match) and numeric times.

    % allow t1/t2 to be different but compatible time classes
    if isa(t1,'datetime') || isa(t2,'datetime')
        % promote both to datetime
        if ~isa(t1,'datetime'); t1 = datetime(t1, 'ConvertFrom','datenum'); end %#ok<DATNM>
        if ~isa(t2,'datetime'); t2 = datetime(t2, 'ConvertFrom','datenum'); end %#ok<DATNM>
        tclass = 'datetime';
        t1n = posixtime(t1);
        t2n = posixtime(t2);
        if isa(tol,'duration')
            tol_sec = seconds(tol);
        else
            tol_sec = double(tol); % seconds
        end
        return;
    end

    if isa(t1,'duration') || isa(t2,'duration')
        % promote both to duration
        if ~isa(t1,'duration'); t1 = seconds(t1); end
        if ~isa(t2,'duration'); t2 = seconds(t2); end
        tclass = 'duration';
        t1n = seconds(t1);
        t2n = seconds(t2);
        if isa(tol,'duration')
            tol_sec = seconds(tol);
        else
            tol_sec = double(tol); % seconds of duration axis
        end
        return;
    end

    % numeric times
    tclass = 'numeric';
    t1n = double(t1(:));
    t2n = double(t2(:));
    tol_sec = double(tol);   % same units as numeric inputs
end

function t = cast_back_time(tn, tclass)
% Cast numeric time axis back to requested class for output table.

    switch tclass
        case 'datetime'
            t = datetime(tn, 'ConvertFrom','posixtime');
        case 'duration'
            t = seconds(tn);
        otherwise
            t = tn; % numeric stays numeric
    end
end

function [bins_u, vals_u] = reduce_duplicates(bins, vals)
% Average values for duplicate bin indices.

    bins = bins(:);
    vals = vals(:);
    [bins_u, ~, ic] = unique(bins, 'stable');
    % accumarray for mean on each bin
    sums = accumarray(ic, vals, [], @sum);
    counts = accumarray(ic, 1,    [], @sum);
    vals_u = sums ./ counts;
end