clc
clear all
data = csvread('data.csv');
data = data/10;
X = data(1096:2190);
dt = 1/365;
gamma=0;
[alpha,sigma,aest,best,cest,dest] = estimParamLongTerm(X,gamma,dt);
t=1:1:T;
mu = aest*cos(2*pi*t*dt+best)+cest;
figure (1)
plot(t,X)
hold on
plot(t,mu)
hold on
resta = abs(X-mu');
desv = std(resta);
plot(t,mu+1*desv)
hold on
plot(t,mu-1*desv)
% ELIMINAR OUTLYERS
% ------------------------------------
indices1 = find(X > mu'+2*desv);
indices2 = find(X < mu'-2*desv);
todos= [indices1;indices2];
X(todos)=[];
T = length(X);
t=1:1:T;
% ------------------------------------
[alpha2,sigma2,aest2,best2,cest2,dest2] = estimParamLongTerm(X,gamma,dt);
t=1:1:T;
mu = aest2*cos(2*pi*t*dt+best2)+cest2;
for j=1:1000
    for i=1:T
        Xgorro(i+1,j) = X(i)+ alpha2*(mu(i)-X(i))*dt +sigma2*X(i)^gamma*sqrt(dt)*randn();
        err(i)=abs(X(i)-Xgorro(i+1,j))/X(i);
    end
    err2(j)=mean(err);
end
Xgorro(1,:)=[];
error = mean(err2)
media= mean(X);
H = max(media-X,0);
Hn=sum(H);
% for n=1:T
%     Hn(n)= sum(H(1:n));
% end
%X = Hn;
figure (2)
plot(t,Xgorro,'g')
hold on
plot(t,X,'r','LineWidth',1)
