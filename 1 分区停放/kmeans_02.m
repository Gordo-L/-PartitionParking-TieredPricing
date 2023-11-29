%�����ⲿ������ȷ��kmeans�㷨�ľ������
sum=zeros(1,15);
N=zeros(1,15);
%�������е�Ķ�Ӧ�ľ�γ��ת�����꣬�����һ��excel�����,�ܹ���m��nά��������(��ʵ��n=2)
all_data=xlsread('C:\Users\ASUS\OneDrive\����\location.xlsx','B2:C96');
[m,n]=size(all_data);
for countk=2:15
    %�����z��k��
    k=countk;
    %��ʼ����������,ѡȡk����ʼ��������Ϊǰk������
    center=all_data([1:k],:);
    %���������ݽ��й���,����k��
    pattern_k=zeros(m,n+1);
    pattern_k(:,[1,n])=all_data(:,:);
    while true
        distance=zeros(1,k);
        count=zeros(1,k);
        new_center=zeros(k,n);
        %��m�����ݽ��й���
        for i=1:m
            for j=1:k
                distance(1,j)=norm(all_data(i,:)-center(j,:)) %�����i���������j���������ĵľ��룻
            end
            [~,index]=min(distance);
            pattern_k(i,n+1)=index;
        end
        %���´�������
        valid_k=0;
        for j=1:k
            for i=1:m
                if (pattern_k(i,n+1)==j)
                    new_center(j,:)=new_center(j,:)+pattern_k(i,[1:n]);
                    count(j)=count(j)+1;
                end
            end
            new_center(j,:)=new_center(j,:)/count(j);
            %�жϵ�j�����������Ƿ��㹻
            if (norm(new_center(j,:)-center(j,:))<0.000001)
                valid_k=valid_k+1;
            end
        end
        if (valid_k==k)
            break;
        else
            center=new_center;
        end
    end
    %new_center��Ϊ����ҪѰ�ҵ�k������ͣ�ŵ�
    
    for j=1:k
        for i=1:m
            if pattern_k(i,n+1)==j
                sum(countk)=sum(countk)+norm(all_data(i,:)-new_center(j,:));
            end
        end
        N(1,countk)=countk;
    end
end
plot(N,sum);
    