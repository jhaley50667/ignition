function [ n , l , d] = likelihood( varargin )

%l = likelihood(x, b, a, h, r1, r2, p)
% Function coumputes the log-likelihood of detections and non-detections
% based on logistic regression of MODIS satellite
%    1/(1+ exp(- a*h +b))
% default values
a = 1.6;
b = 2.3;
h = 7;
r1 = 0.8;
r2 = 0.1;
p = 2.0;

dx = 1;

x = varargin{1};
b = varargin{2};
a = varargin{3};
r1 = varargin{4};
r2 = varargin{5};
%correction = 0;
correction =1*1/(1+exp(b));

if x < 0
    p = 1/(1+exp(-a*h*exp(-abs(r1*x).^p)+b))-correction;
   % p1 = 1/(1+exp(-a*h*exp(-abs(r1*x+dx).^p)+b))-correction;
    %d = (log(p1)-log(p))/dx;
else 
    p = 1/(1+exp(-a*h*exp(-abs(r2*x).^p)+b))-correction;
    %p1 = 1/(1+exp(-a*h*exp(-abs(r2*x+dx).^p)+b))-correction;
    %d = (log(p1)-log(p))/dx;
end

%replace if with heavisdie function
% p = (1/(1+exp(-a*h*exp(-abs(r1*x).^p)+b))-correction)*heaviside(x)
%       + (1/(1+exp(-a*h*exp(-abs(r2*x).^p)+b))-correction)*heaviside(-x);

%derivatives
if x < 0
   % d = (log(p1)-log(p))/dx;
    %d = -a*h*p*r1*(r1*x)^(p-1)*exp(b-a*exp(-abs(r1*x).^p))/(1+exp(-a*h*exp(-abs(r1*x).^p)+b));
else 
    %d = -(log(p1)-log(p))/dx;
    %d = -a*h*p*r2*(r2*x)^(p-1)*exp(b-a*exp(-abs(r2*x).^p))/(1+exp(-a*h*exp(-abs(r2*x).^p)+b));
end

l = log(p);
n = log(1-p);
d = 1;



end

