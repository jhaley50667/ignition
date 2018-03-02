%test script
close all
left = -5;
right = 20;
num = 1000;

x = linspace(left,right,num)';
y = zeros(length(x),2);
derivs = zeros(length(x),2);
d = zeros(length(x),2);

b = 1;
a = 12;
r1 = 0.8;
r2 = 0.2;
for i=1:length(x)
    in = x(i);
    [p,l,d_temp] = likelihood(in,b,a,r1,r2);
    y(i,1) = p;
    y(i,2) = l;
    derivs(i,1) = d_temp;
end

%compute derivatives using forward diff approx
dx = (right-left)/num;
for i=1:length(x)-1
   d(i,1) = (y(i+1,1)-y(i,1))/dx;
   d(i,2) = (y(i+1,2)-y(i,2))/dx;
end
d(length(x),1) = d(length(x)-1,1); 
d(length(x),2) = d(length(x)-1,2);
%[y(:,1) y(:,2)] = likelihood(x,b,a,r1,r2);

hold on
plot(x,y(:,2))
plot(x,y(:,1))

figure 
hold on
plot(x,d(:,2))
plot(x,d(:,1))

% figure 
% plot(x,derivs(:,1))
