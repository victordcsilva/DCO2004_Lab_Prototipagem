clear
N=1e6;
vtK=[0 5 10];
totPower=1;

for ik=1:length(vtK)
    K=vtK(ik);
    s=sqrt(K/(K+1)*totPower);
    sigma=totPower/sqrt(2*(K+1));
    
    X=s+sigma*randn(N,1);
    Y=0+sigma*randn(N,1);
    Z=X+j*Y;
    [val,bins]=hist(abs(Z),100);
    binWidth=bins(2)-bins(1);
    r=0:binWidth:max(bins);
    figure(1)
    subplot(3,1,ik)
    if K==0
        rayleigh_pdf=r./(sigma.^2).*exp(-r.^2/(2*sigma.^2));
        plot(r,rayleigh_pdf,'g*')
        hold on
        fRice=(2.*r(K+1)./totPower).*(exp(-(r.^2.*(K+1)/totPower)-K)).*besseli(0,2.*r.*sqrt(K*(K+1)./totPower));
    
        bar(bins,val./(binWidth*sum(val)),1)
        hold on
        plot(r,fRice,'r')
        legend(['Rayleigh'],['Rice K = ',num2str(K),' - pelas amostras'],['Rice K = ',num2str(K),' - teórico'])
        xlim([0 4])
    else    
        fRice=(2.*r(K+1)./totPower).*(exp(-(r.^2.*(K+1)/totPower)-K)).*besseli(0,2.*r.*sqrt(K*(K+1)./totPower));
    
        bar(bins,val./(binWidth*sum(val)),1)
        legend()
        hold on
        plot(r,fRice,'r')
        xlim([0 2])
        legend(['Rice K = ',num2str(K),' - pelas amostras'],['Rice K = ',num2str(K),' - teórico'])
    end
end
        