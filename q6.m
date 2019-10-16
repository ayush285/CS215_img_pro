clear
I1 = double(imread('T1.jpg'));
I2 = double(imread('T2.jpg'));

d = size(I1);
height = d(1);
width = d(2);
n = height*width;

shift_I1 = I1(:)-mean(I1(:));
r_t=zeros(21,1);
qmi_t=zeros(21,1);
%shifted_image = imtranslate(I2, [-11,0]);
            
for t=-10:10
    shifted_image = imtranslate(I2, [t,0]);
    ssi = shifted_image(:)-mean(shifted_image(:));
    u = sum(ssi.*shift_I1);
    r_t(t+11) = u/sqrt(sum(shift_I1.^2)*sum(ssi.^2));
    
    a_bins = zeros(26,1);
    b_bins = zeros(26,1);
    j_bins = zeros(26);
    for i=1:width
        for j=1:height
            m = 1+floor(I1(j,i)/10);
            n = 1+floor(shifted_image(j,i)/10);
            
            a_bins(m) = a_bins(m)+1;
            b_bins(n)=b_bins(n)+1;
            j_bins(m,n) = j_bins(m,n)+1; 
        end
    end
    a_bins = a_bins/sum(a_bins);
    b_bins = b_bins/sum(b_bins);
    j_bins = j_bins/sum(j_bins(:));
    
    for i=1:26
        for j=1:26
            qmi_t(t+11) = qmi_t(t+11)+(j_bins(i,j)-a_bins(i)*b_bins(j))^2;
        end
    end
    
end
t=-10:10;
s = sprintf('I_2 is the second image');
figure;plot(t, r_t); xlabel('t'); ylabel('correlation coefficient'); title(s);
figure;plot(t, qmi_t); xlabel('t'); ylabel('QMI'); title(s);

clear;

I1 = double(imread('T1.jpg'));
I2 =  255-I1;

d = size(I1);
height = d(1);
width = d(2);
n = height*width;

shift_I1 = I1(:)-mean(I1(:));
r_t=zeros(21,1);
qmi_t=zeros(21,1);

%shifted_image = imtranslate(I2, [-11,0]);
    
for t=-10:10
    shifted_image = imtranslate(I2, [t,0]);
    ssi = shifted_image(:)-mean(shifted_image(:));
    u = sum(ssi.*shift_I1);
    r_t(t+11) = u/sqrt(sum(shift_I1.^2)*sum(ssi.^2));
    
    a_bins = zeros(26,1);
    b_bins = zeros(26,1);
    j_bins = zeros(26);
    for i=1:width
        for j=1:height
            m = 1+floor(I1(j,i)/10);
            n = 1+floor(shifted_image(j,i)/10);
            
            a_bins(m) = a_bins(m)+1;
            b_bins(n)=b_bins(n)+1;
            j_bins(m,n) = j_bins(m,n)+1; 
        end
    end
    a_bins = a_bins/sum(a_bins);
    b_bins = b_bins/sum(b_bins);
    j_bins = j_bins/sum(j_bins(:));
    
    for i=1:26
        for j=1:26
            qmi_t(t+11) = qmi_t(t+11)+(j_bins(i,j)-a_bins(i)*b_bins(j))^2;
        end
    end
    
end
t=-10:10;
s = sprintf('I_2 = 255 - I_1');
figure;plot(t, r_t); xlabel('t'); ylabel('correlation coefficient'); title(s);
figure;plot(t, qmi_t); xlabel('t'); ylabel('QMI'); title(s);
