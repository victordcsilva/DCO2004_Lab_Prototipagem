clear
N=2000;
ts=0.1;
x=0:ts:ts+5;
sigma=1;
u=rand(N,1);
rReal=sigma*sqrt(-2*log(u));
pdfTeo=(x./(sigma^2)).*exp(-((x./sigma).^2)/2);
rComplexo=randn(N,1)+j*randn(N,1);

figure(1)
subplot(3,1,1)

xh=hist(rReal,x);
temp=x(1:length(x)-1);
width=ts;
bar(temp,xh(1:length(xh)-1)./(sum(xh(1:length(xh)-1)).*ts),'b')
hold on
plot(x,pdfTeo,'r')
legend('Histograma das amostras - canal real','PDF teórica Rayleigh')
xlim([0,5])
title('PDF da envoltória do canal Rayleigh real')

subplot(3,1,2)
xh=hist(abs(rComplexo),x);
temp=x(1:length(x)-1);
width=ts;
bar(temp,abs(xh(1:length(xh)-1))./(sum(abs(xh(1:length(xh)-1)).*ts)),'b')
hold on
plot(x,pdfTeo,'r')
legend('Histograma das amostras - canal complexo','PDF teórica Rayleigh')
xlim([0,5])
title('PDF da envoltória do canal Rayleigh Complexo')

subplot(3,1,3)

xhra=hist(angle(rComplexo))
bar(linspace(-170,170,10),xhra./(sum(xhra)*ts) ,'b')

title('PDF da fase do canal Rayleigh Complexo')
ylim([0, 1.3])
