function [w] = pocket(X, y, w, iterNum, indexList)
    
m = length(y);
while iterNum > 0
    nowIndex = indexList(randi([1 m]));
    xnow = X(nowIndex, :);
    if sign(xnow * w) == y(nowIndex) || (sign(xnow * w) == 0 && y(nowIndex) == -1)
        continue
    else
        wUpdate = w + (y(nowIndex) * xnow)';
        % up1 = verify(X, y, w)
        % up2 = verify(X, y, wUpdate)
        if verify(X, y, w) < verify(X, y, wUpdate)
            w = wUpdate;
        end
        iterNum -= 1;
    end
end

end

