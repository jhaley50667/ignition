function [ v0 v1  ] = like1_new(dw, t, stretch )
%copy-cat of like1 in Matlab directory, using new log-likelihood

[m n] = size(t);

v0 = zeros(m,n);
v1 = zeros(m,n);

%likelihood parameters to match like1
b = 3.35;
a = 2;
r1 = 0.2;  %fire die-out rate
r2 = 0.08; %fire heat-up rate

%compute likelihoods

for i=1:m
    for j=1:n
        in = t(i,j);
        [likely not_likely deriv] = likelihood(in,b,a,r1,r2);
        if dw(i,j) < 0
            v0(i,j) = not_likely;
        else
            v0(i,j) = likely;
        end
    end
end

%compute derivatives using forward difference on columns of v0
for i = 1:n
    for j = 1:m-1
        dx = 1/m;
%         r = v0(j+1,i);
%         l = v0(j,i);
        d = (v0(j+1,i)-v0(j,i))/dx;
        v1(j,i) = d;
    end
    v1(m,i) = v1(m-1,i);
end


end

