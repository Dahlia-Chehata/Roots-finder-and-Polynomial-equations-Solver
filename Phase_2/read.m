function [sz,A,B,initGuess] = Read(x)
A=[];
B=[];
symb=[];
str=[];

if exist(x, 'file') ~= 2
    disp('File not found');
    return;
end

fid=fopen(x,'r');
sz=str2double(fgetl(fid));
initGuess=zeros(0,sz);

for i=1:1:sz
    initGuess(i)=str2double(fgetl(fid));
end
if isnan(initGuess())
   fclose(fid);
   fid=fopen(x);
   fgetl(fid);
end
while 1
    tline= fgetl(fid);
    if ~ischar(tline), break, end
    str=[str,tline];
end
fclose(fid);

symb=symvar(str);
variables =sym(symb);

fid=fopen(x);
if isnan(initGuess)
 fgetl(fid);
 initGuess=zeros(1,sz);
else 
for i=1:1:sz+1
   fgetl(fid);
end
end
while 1
    tline= fgetl(fid);
    if ~ischar(tline), break, end
    [Atemp,Btemp]=equationsToMatrix(sym(tline),variables);
    A=[A;Atemp];
    B=[B;Btemp];
    A=double(A);
    B=double(B);
end
fclose(fid);
end