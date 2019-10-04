load('D_iris.mat');

%Dataset preparation
D = D_iris(1:4,:);
X1 = D(:,1:50);
X2 = D(:,51:100);
X3 = D(:,101:150);
rand('state',111)
r1 = randperm(50);
Xtr1 = X1(:,r1(1:40));
Xte1 = X1(:,r1(41:50));
rand('state',112)
r2 = randperm(50);
Xtr2 = X2(:,r2(1:40));
Xte2 = X2(:,r2(41:50));
rand('state',113)
r3 = randperm(50);
Xtr3 = X3(:,r3(1:40));
Xte3 = X3(:,r3(41:50));

y = [ones(40,1); -ones(80,1)];
Xtr1(5,:) = ones(1,40);
Xtr2(5,:) = ones(1,40);
Xtr3(5,:) = ones(1,40);
X1_hat = [Xtr1'; Xtr2'; Xtr3'];
X2_hat = [Xtr2'; Xtr1'; Xtr3'];
X3_hat = [Xtr3'; Xtr1'; Xtr2'];

%Get w and b
w1_hat = inv(X1_hat'*X1_hat)*X1_hat'*y;
w2_hat = inv(X2_hat'*X2_hat)*X2_hat'*y;
w3_hat = inv(X3_hat'*X3_hat)*X3_hat'*y;

%Testing
mis_class = 0;


W = [w1_hat(1:4,:) w2_hat(1:4,:) w3_hat(1:4,:)];
b = [w1_hat(5,:); w2_hat(5,:); w3_hat(5,:)];
Xte123 = [Xte1 Xte2 Xte3];
E = zeros(30,3);
f = zeros(3,30);
for i =1:30
   f(:,i) = W'*Xte123(:,i)+b;    
end

label = [ones(1,10) ones(1,10)*2 ones(1,10)*3];

for i =1:30
   [value,pos] = max(f(:,i));
   E(i,pos) = 1;
   if pos ~= label(i)
       mis_class = mis_class+1;
   end
end
fprintf('error rate:%f%%\n',mis_class/30*100);





