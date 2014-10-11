function [w, wPocket] = pocket(X, y, w, iterNum, indexList)
    
wPocket = zeros(size(X, 2), 1);
m = length(y);
wErr = m;
while iterNum > 0
    nowIndex = indexList(randi([1 m]));
    xnow = X(nowIndex, :);
    if sign(xnow * w) == y(nowIndex) || (sign(xnow * w) == 0 && y(nowIndex) == -1)
        continue
    else
        w = w + (y(nowIndex) * xnow)';
        err = verify(X, y, w);
        if err < wErr
            wPocket = w;
            wErr = err;
        end
        iterNum -= 1;
    end
end

end

