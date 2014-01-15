clc
clear all;
close all;

ENa=55;
EK=-90;
El=-70;
deltat=0.05;
gNa=120;  
gK=36;    
gL=1;
c=1;  
Vrest=-70;
I=20;

    for i=1:2000
        
        if i==1
            V(i)=Vrest;
        else
            V(i)=V(i-1)+(deltat*(V_inf(i-1)-V(i-1))/tau(i-1));
        end

        alpha_n(i)=(-0.01*(V(i)+60)/(exp(-(V(i)+60)/10)-1));
        beta_n(i)=0.125*exp(-(V(i)+70)/80);
        n_inf(i)=alpha_n(i)/(alpha_n(i)+beta_n(i));
        tau_n(i)=1/(alpha_n(i)+beta_n(i));
       
        alpha_m(i)=(-0.1*(V(i)+45))/(exp(-(V(i)+45)/10)-1);
        beta_m(i)=4*exp(-(V(i)+70)/18);
        m_inf(i)=alpha_m(i)/(alpha_m(i)+beta_m(i));
        tau_m(i)=1/(alpha_m(i)+beta_m(i));
     
        alpha_h(i)=(0.07*exp(-(V(i)+70)/20));
        beta_h(i)= 1/((exp(-(V(i)+40)/10))+1);
        h_inf(i)=alpha_h(i)/(alpha_h(i)+beta_h(i));
        tau_h(i)=1/(alpha_h(i)+beta_h(i));


        if i==1
            n(i)=n_inf(i);
            m(i)=m_inf(i);
            h(i)=h_inf(i);
        else 
            n(i)=n(i-1)+(deltat*((n_inf(i)-n(i-1))/tau_n(i)));
            m(i)=m(i-1)+(deltat*((m_inf(i)-m(i-1))/tau_m(i)));
            h(i)=h(i-1)+(deltat*((h_inf(i)-h(i-1))/tau_h(i)));
        end
        
       
       GNa(i)=m(i)^3*h(i)*gNa;
       GK(i)=n(i)^4*gK;
       
       V_inf(i)= ((ENa*GNa(i))+(EK*GK(i))+(El*gL)+I)/(GNa(i)+GK(i)+gL);
       tau(i)=c/(GNa(i)+GK(i)+gL);
           
    end

plot(V);
