function err = verify(X, y, w)

m = length(y);
yCompute = sign(X * w);
err = 0;
for i = 1:m
    if yCompute(i) != y(i) 
        err += 1;
    end
end
end
