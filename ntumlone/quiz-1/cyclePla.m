function [iterNum, w] = cyclePla(X, y, w, indexList, alpha = 1)
    
m = length(y);
iterNum = 0;
i = 0;
oknum = 0;
while 1
    i = rem((i + 1), (m + 1));
    if i == 0
        i = 1;
    end
    nowIndex = indexList(i);
    xnow = X(nowIndex, :);
    if sign(xnow * w) == y(nowIndex) || (sign(xnow * w) == 0 && y(nowIndex) == -1)
        oknum += 1;
        if oknum == m
            break;
        else
            continue;
        end
    else
        oknum = 0;
        iterNum = iterNum + 1;
        w = w + alpha * (y(nowIndex) * xnow)';
    end
end

end
