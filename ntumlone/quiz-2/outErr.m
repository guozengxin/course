function [err] = outErr(s, theta)

err = 0.5 + 0.3 * s * (abs(theta) - 1.0);
