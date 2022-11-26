function [cl,cd,alpha,cl_cd,cm] = Extract_Alpha_Cl_Cd_ClCd_Cm(tab)

%Variables
alpha = zeros(size(tab,1),1);
cl = zeros(size(tab,1),1);
cd = zeros(size(tab,1),1);
cl_cd = zeros(size(tab,1),1);
cm = zeros(size(tab,1),1);

%Vector Extraction
for i = 1:size(tab,1)

alpha(i,1) = tab(i,1);
cl(i,1) = tab(i,2);
cd(i,1) = tab(i,3);
cl_cd(i,1) = cl(i,1)/cd(i,1);
cm(i,1) = tab(i,5);
end


end

