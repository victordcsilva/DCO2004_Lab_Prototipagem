clear
clc
N=10^6;
EbN0dB=-5:2:20;
EbN0=10.^(EbN0dB/10);
totPower=1;
K=[0 5 30];
d=rand(N,1)>0.5;
x=2.*d-1;
simBER_ricean=zeros(length(EbN0dB));
figure
plotStyleSim=['b-*';'r-o';'k-d';'g-^';'m->';'c-<'];
chLegend=[];
for i=1:length(K)
    k=K(i);
    disp(['Simulado K = ',num2str(k)])
    s = sqrt( k/(k+1)*totPower );
    sigma = totPower/sqrt(2*(k+1));
    for ik=1:length(EbN0dB)
        noise = 1./sqrt(2).*(randn(N,1)+j.*randn(N,1));
        n = noise*10^(-EbN0dB(ik)/20);
        h = ((sigma.*randn(N,1)+s)+j.*(randn(N,1).*sigma+0));
        y_ricean=h.*x+n ;
        y_ricean_cap=y_ricean./h ;
        r_ricean=real(y_ricean_cap)>0;
        simBER_ricean(ik)=sum(bitxor(d,r_ricean));
    end
    simBER_ricean=simBER_ricean./N;
    semilogy(EbN0dB,simBER_ricean,plotStyleSim(i,1:3))
    hold all
    chLegend=[chLegend;{['K = ' num2str(k)]}];
end

BER_rayleigh_teorica = 0.5.*(1-sqrt(EbN0./(1+EbN0)));
BER_awgn_teorica = 0.5*erfc(sqrt(EbN0));
semilogy(EbN0dB,BER_rayleigh_teorica,'k-');

chLegend=[chLegend;{['Rayleigh teórico']}];
semilogy(EbN0dB,BER_awgn_teorica,'b--');
chLegend=[chLegend;{['AWGN teórica']}];

title('Eb/N0 Vs BER for BPSK over Rician Fading Channels with AWGN noise');
xlabel('Eb/N0(dB)');
ylabel('Bit Error Rate or Symbol Error Rate');
axis([-5 20 10^(-5) 10^0]);
legend(chLegend);


        
