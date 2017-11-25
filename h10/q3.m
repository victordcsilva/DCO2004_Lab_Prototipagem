clear
N=10^6;
EbN0dB=-5:2:20;
d=rand(N,1)>0.5;
x=2.*d-1;

BER_rayleigh_simulada=zeros(length(EbN0dB));
BER_awgn_simulada=zeros(length(EbN0dB));
for i=1:length(EbN0dB)
    noise=1/sqrt(2).*(randn(N,1)+j.*randn(N,1));
    n=noise*10^(-EbN0dB(i)/20);
    h=1/sqrt(2)*(randn(N,1)+j*randn(N,1));
    y_awgn=x+n;
    y_rayleigh=h.*x+n;
    y_rayleigh_cap=y_rayleigh./h;
    r_rayleigh=real(y_rayleigh_cap)>0;
    r_awgn=real(y_awgn)>0;
    BER_rayleigh_simulada(i)=sum(bitxor(d,r_rayleigh));
    BER_awgn_simulada(i)=sum(bitxor(d,r_awgn));
end
BER_rayleigh_simulada=BER_rayleigh_simulada/N;
BER_awgn_simulada=BER_awgn_simulada/N;
EbN0=10.^(EbN0dB/10);
BER_rayleigh_teorica=0.5.*(1-sqrt(EbN0./(1+EbN0)));
BER_awgn_teorica = 0.5*erfc(sqrt(EbN0));

semilogy(EbN0dB,BER_rayleigh_simulada,'go')

hold on
semilogy(EbN0dB,BER_awgn_simulada,'ro')
semilogy(EbN0dB,BER_rayleigh_teorica,'k-')
semilogy(EbN0dB,BER_awgn_teorica,'b--')
grid on
xlabel('E_b/N_0(dB)')
ylabel('BER ou Pe')
legend('Rayleigh simulada','AWGN simulada','Rayleigh teórica','AWGN teórica','Location','southwest');
axis([-5 20 10^-5 1.2])

