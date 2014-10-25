function [minErr, s, theta] = minInErr(x, y)

minErr = 1.0;
allS = [1, -1];
thetas = mean(x([1:19], :) + x([2:20], :), 2);

for j = 1:length(allS)
    tempS = allS(j);
    for i = 1:length(thetas)
        err = inErr(x, y, tempS, thetas(i));
        if err < minErr
            minErr = err;
            theta = thetas(i);
            s = tempS;
        end
    end
end
