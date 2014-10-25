function [err] = inErr(x, y, s, theta)

calY = s .* sign(x - theta);

errCount = length(find(y != calY));
err = errCount / length(y);
