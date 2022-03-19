function [H,M,B]=DJAM(Hm,Bm);
mu0=4*pi*10^-7;
    global PAR  

    Ms =PAR(1); 
    k  = PAR(2);
    c  =PAR(3);
    alpha=PAR(4);
    a = PAR(5);
 
  B=zeros(size(Hm));
  jj=0;nl=length(Hm)/6;
M=zeros(size(Hm));
M(1)=(B(1)/mu0)-(Hm(1));
 for(j=1:size(Hm,2))
 for i=2:size(Hm,1)
dH=Hm(i,j)-Hm(i-1,j);dB=Bm(i,j)-Bm(i-1,j);
 if(dH>0)
 delta=1;
 else
 delta=-1;
 end
  He=Hm(i-1,j)+alpha*M(i-1,j);
  Man=Ms*(coth((He)/a)-a/(He));
  dMandHe=Ms*(1-(coth((He)/a)^2)+(a/(He))^2)/a;
  Mirr=(M(i-1,j)-c*Man)/(1-c);%   if i>=2 & i<=50 
if i==(nl+1)+jj
         jj=jj+nl;
     end
 dH=Hm(i)-Hm(i-1);dB=Bm(i)-Bm(i-1);
 if(dH>0)
 delta=1;
 else
 delta=-1;
 end
      if (Man-Mirr)*dH>0
      deltaM=1;
   end
  if (Man-Mirr)*dH<=0
      deltaM=1;  
  end
dMirrdHe=deltaM*(Man-Mirr)/(k*delta);
dMdH=(((1-c)*(dMirrdHe))+(c*dMandHe))/(1-(alpha*c*dMandHe)-(alpha*(1-c)*dMirrdHe));
%dMdH=(((1-c)*(dMirrdHe))+(c*dMandHe))/(1-alpha*(1-c)*(dMirrdHe)-(alpha*c*dMandHe));
  M(i,j)=M(i-1,j)+dMdH*dH;
  B(i,j)=mu0*(Hm(i,j)+M(i,j));
   end
 end
 B=B(1:end,1:j);H=Hm(1:end,1:j);
 end
