function [alpha2,sigma2,aest,best,cest,dest] = estimParamLongTerm(x,v,dt)
T = length(x);
s=62500;
m= hpfilter(x,s);
mpunto = diff(m);
sumanum = 0;
sumaden = 0;
% Primera estimación de alfa.
for i=2:T
    sumanum = sumanum + ((x(i)-x(i-1)-mpunto(i-1)*dt)*(m(i-1)-x(i-1))/(x(i-1))^(2*v));
    sumaden = sumaden + (((m(i-1)-x(i-1))/(x(i-1))^v)^2)*dt;
end  
alpha = sumanum/sumaden;
% Primera estimación de sigma
suma=0;
for i=2:T
    suma = suma + ((x(i)-x(i-1)-(alpha*(m(i-1)-x(i-1))+mpunto(i-1))*dt)/((x(i-1))^v))^2;
end
sigma = sqrt(suma/(T*dt));
% FASE 2: Reestimación
mu1 = m(2:end)+mpunto/alpha;
% cvx_begin quiet
%     variables p(3)
%     error =0;
%     for i=1:T-1
%         error = error + (mu1(i)-(p(1)+p(2)*cos(2*pi*i*dt)+p(3)*i))^2;
%     end
%     minimize error
% cvx_end
% aest =p(1)
% best= p(2)
% cest=p(3)
t=2:1:T;
t= t';
fun = @(x)sum((mu1 -(x(1)*cos(2*pi*t*dt+x(2))+ x(3))).^2);
x0 = [0,0,1,0]; 
solu = fminsearch(fun,x0);
aest = solu(1);
best = solu(2);
cest = solu(3);
dest = solu(4);
mu2 = aest*cos(2*pi*t*dt+best)+cest;
%plot(t,mu1)
%hold on
% plot(t,mu2,'r')
% hold on 
% plot(t,x(1:1094),'k')
sumanum = 0;
sumaden = 0;
% Segunda estimación de alfa.
for i=2:T
    sumanum = sumanum + ((x(i)-x(i-1))*(mu2(i-1)-x(i-1)*dt))/(x(i-1))^(2*v);
    sumaden = sumaden + ((mu2(i-1)-x(i-1))/(x(i-1))^v)^2*dt;
end  
alpha2 = sumanum/sumaden;
% Segunda estimación de sigma
suma=0;
for i=2:T
    suma = suma + ((x(i)-x(i-1)-(alpha2*(mu2(i-1)-x(i-1)))*dt)/((x(i-1))^v))^2;
end
sigma2 = sqrt(suma/(T*dt));

end