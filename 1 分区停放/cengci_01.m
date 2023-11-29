%��ξ����㷨
clear all;
close all;
clc;
%�����z��k��
%�������е�Ķ�Ӧ�ľ�γ��ת�����꣬�����һ��excel�����,�ܹ���m��nά��������(��ʵ��n=2)
k=input("");
all_data=xlsread('C:\Users\ASUS\OneDrive\����\location.xlsx','B2:C96');
[m,n]=size(all_data);
%���������ݽ��й��ࣺ�Ե����ϣ�����������m�ࡣ
pattern_k=zeros(m,n+1);
for i=1:m
    pattern_k(i,[1,n])=all_data(i,:);
    pattern_k(i,n+1)=i;
end
%����ÿ��������֮���ƽ������/������/��С���룬�������Distance�С�
%�������ƽ������.
for i=1:m
    for j=1:m
        Distance(i,j)=norm(all_data(i,:)-all_data(j,:));
    end
end

%�Ե����Ͻ��о��ࣺ
%���õ�ǰ�������q
q=m;
while q>k
    %�ҳ������������������
    index1=1;
    index2=2;
    for i=1:q
        for j=(i+1):q
            if(Distance(i,j)<Distance(index1,index2))
                index1=i;
                index2=j;
            end
        end
    end
    %������������ϲ�����
    for i=1:m
        if(pattern_k(i,n+1)==index2)
            pattern_k(i,n+1)=index1;
        elseif(pattern_k(i,n+1)>index2)
            pattern_k(i,n+1)=pattern_k(i,n+1)-1;
        end
    end
    %�Ծ��������и���:����ɾ����index2�У���index2�У������¼����index1����q-1��ľ���
    Distance(index2,:)=[];
    Distance(:,index2)=[];
    for i=1:(q-1)
        distance=0;%��index1�����i�������Ԫ���ܾ���
        count1=0;%��index1������Ԫ�ظ���
        count2=0;%��i������Ԫ�ظ���
        for j=1:m
            if(pattern_k(j,n+1)==index1)
                count1=count1+1;
            end
        end
        for j=1:m
            if(pattern_k(j,n+1)==i)
                count2=count2+1;
            end
        end
        for j=1:m
            for l=1:m
                if(pattern_k(j,n+1)==index1&&pattern_k(l,n+1)==i)
                    distance=distance+norm(all_data(i,:)-all_data(j,:));
                end
            end
        end
        Distance(index1,i)=distance/(count1*count2);
        Distance(i,index1)=distance/(count1*count2);
    end
    q=q-1;
end

%�ټ���ÿ����������ĵ�
center=zeros(k,n);
for i=1:k
    sum=zeros(1,n);
    count=0;
    for j=1:m
        if(pattern_k(j,n+1)==i)
            sum=sum+all_data(j,:);
            count=count+1;
        end
        center(i,:)=sum/count;
    end
end

%�������ͼ����ʾ����������
plot(all_data(:,1),all_data(:,2),'*');
grid on;
figure;
hold on;
for i=1:m
    for j=1:k
        if pattern_k(i,n+1)==j
            plot(pattern_k(i,1),pattern_k(i,2),'r*');
            plot(center(j,1),center(j,2),'ko');
        end
    end
end
grid on; %��ͼ��ʱ��������߸�    
    
%���Ч���ܲΪʲô�أ������һ�㶼����������Ҵ�����ľ������ı˴����ǳ����������Ǿ�����������?
            
    
