function correct = verify(X, y, w)

m = length(y);
yCompute = sign(X * w);
correct = 0;
for i = 1:m
    if yCompute(i) == y(i) || (yCompute(i) == 0 && y(i) == -1)
        correct += 1;
    end
end
