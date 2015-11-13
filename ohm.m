
%%
%individual figures: lateness
close all

clc
clear
st=datestr(now);
% make sure they have same length in char counts
% gives vm folder names
vms = cellstr(['xen_bimo_ohm']);
%vms = cellstr(['rtxen-480';'  xen-480']);
%vms = cellstr(['kvm-500']);
%vms = cellstr(['rtxen-480-0.2-8.4-fine';'  xen-480-0.2-8.4-fine';'  kvm-480-0.2-8.4-fine';' bare-480-0.2-8.4-fine']);
%vms = cellstr(['rtxen-480-3.2-8.4-fine';'  xen-480-3.2-8.4-fine';'  kvm-480-3.2-8.4-fine';' bare-480-3.2-8.4-fine']);

%vms = cellstr(['rtxen-480';'  xen-480';'  kvm-480';' bare-480']);
%ratio files name under the folders above'
dists = cellstr(['bimo-medium_uni-longRTXen   ';...
%dists = cellstr([
                 'bimo-medium_uni-moderate    ';...
                 ]);
file_dists = cellstr(['  bimo-480-jobs';...
                      ' heavy-480-jobs';...
                      'medium-480-jobs';...
                      ' light-480-jobs';...
                 ]);
dists_title = cellstr(['uni-moderate result';
                       '   uni-light result']);
% distributions on x-axis
% 480, with folder name xen, rtxen, they are 8 cores
%xaxis=[0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 4.2 4.4 4.6 4.8 5 5.2 5.4 5.6 5.8 6 6.2 6.4 6.6 6.8 7 7.2 7.4 7.6 7.8 8 8.2 8.4];

% 484, 8 cores
%xaxis=[3.2 3.6 4.2 4.6 5.2 5.6 6.2 6.6 7.2 7.6 8 8.2 8.4];
%xaxis=[3.2 3.4 3.6 3.8 4.2 4.4 4.6 4.8 5.2 5.4 5.6 5.8 6.2 6.4 6.6 6.8 7.2 7.4 7.6 7.8 8 8.2 8.4];

xaxis=[1 2 3 4 5 6 7 8];
% line, maker style
lw=[10,6,4,3];
ms=[12,10,8,6];
ls=cellstr(['ob';'xg';'xm';'^k']);

pmod = cellstr(['_1.0_';'_2.0_';'_3.0_';'_4.0_';'_5.0_';'_6.0_';'_7.0_';'_8.0_']);
plong = cellstr(['_1_';'_2_';'_3_';'_4_';'_5_';'_6_';'_7_';'_8_']);

plong_lateness{1}=[];
pmod_lateness{1}=[];
p_min=ones(2,8).*inf;

%figure
for j=1:length(dists)
    c{1}=[];
    for i=1:length(vms)
        for m=1:8
            c{m}=[];
            for k=0:0


                if(j<2) %long
                    %plong_lateness{m}=[];
                    strcat(strtrim(vms{i}),'/',dists{j},plong{m},num2str(k))
                    fid = fopen(strcat(strtrim(vms{i}),'/',dists{j},plong{m},num2str(k),'/cxs_out'));
                else
                    %pmod_lateness{m}=[];
                    fid = fopen(strcat(strtrim(vms{i}),'/',dists{j},pmod{m},num2str(k),'/cxs_out'));
                    strcat(strtrim(vms{i}),'/',dists{j},pmod{m},num2str(k))
                
                end
                               cnt=1;
                tline = fgets(fid);

                while ischar(tline)

                    if(1==(isspace(tline)))
                     
                    elseif(ischar(tline))

                        oline = strsplit(strtrim(tline));


%                         if (strcmp(oline(1),'#')<1)
%                             if(str2double(oline(6))<0)
%                                 tmp=c{m};
                                ov = str2double(oline(3));
                                tmp(cnt)=ov;
                                c{m}=tmp;
                                cnt=cnt+1;
                                if(ov < p_min(j,m))
                                   p_min(j,m) = ov;
                                end
%                             end
%                         end
                        

                    end
                    tline = fgets(fid);
                end
                fclose(fid);
                

    %         schdublilty(i,:) = (suc./sum)';
    %         %subplot(2,2,j);
    %         plot(xaxis,schdublilty(i,:),ls{i},'LineWidth',lw(i),'MarkerSize',ms(i))
    % 
    %         hold on
            end
        end
    end
%     ylim([0 1.1])
%     h_title=title(strtrim(dists_title{j}),'Interpreter', 'none');
%     set(h_title,'FontSize',20);
%    
%     % update the line below correspond to the vms list above
%     h_legend=legend('Xen-RTDS', 'Xen-credit','KVM','Bare-Metal','Location','sw');
%     set(h_legend,'FontSize',15);
%     set(gca,'fontsize',15)
%     xlabel('Task Set Utilization Distribution (8cores)','FontSize',15)
%     ylabel('Fraction of schedulable jobs','FontSize',15)
%     grid on
%     hold off
%    
%    
%    
% set(h,'Units','Inches');
% 
% pos = get(h,'Position');
% 
% set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% 
% print(h,strtrim(file_dists{j}),'-dpdf','-r0')
    if (j<2)
        plong_lateness=c;
    else
        pmod_lateness=c;
    end
end
st
datestr(now)
%%
close all
clc
dists_title = cellstr(['bimo-long-period-litmus-rt-context-switching-overhead        ';...
                       'bimo-moderate-period-litmus-rt-context-switching-overhead    ';...
                 ]);
             figure
tmp_lateness={plong_lateness, pmod_lateness};
for k = 1:length(tmp_lateness)
    lateness=tmp_lateness{k};
    cnt=1;
    xmat=[];
    mat=[];
    for i=1:8
       if(~isempty(lateness{i}))
           tmp = lateness{i};
           for j=1:length(lateness{i})

               mat(cnt)=tmp(j);%./1000000;
               xmat(cnt)=i;
               cnt=cnt+1;
           end
       end
    end
%     figure
    subplot(2,1,k)
    boxplot(mat,xmat)
    h_title=title(strcat('Xen-',strtrim(dists_title{k})),'Interpreter', 'none');
    set(h_title,'FontSize',20);    
    set(gca,'fontsize',15)
    xlabel('Normalized Task Set Utilization','FontSize',15)
    ylabel('Clock Clcyes','FontSize',15)
    ylim([0 7e4])
end
% cnt=1;
% xmat=[];
% mat=[];
% for i=1:8
%    if(~isempty(plong_lateness{i}))
%        tmp = plong_lateness{i};
%        for j=1:length(plong_lateness{i})
% 
%            mat(cnt)=tmp(j);
%            xmat(cnt)=i;
%            cnt=cnt+1;
%        end
%    end
% end
% figure
% 
% boxplot(mat,xmat)
%%
% different view of fig 2
% clc
% clear
% close all

%format long;
data_number_per_file = 27;
%hp1:xen, hp2:rtxen, hp3:bare-metal
vms = cellstr(['hp1';'hp2';'hp3']);
vms_name =  cellstr(['hp1-x e n';'hp2-rtxen';'hp3-bar e']);
exct =  cellstr(['0.10';'1   ';'10  ';'50  ';'100 ';'200 ']);

% machine ='xen';


mat = zeros(data_number_per_file*length(vms),length(exct));

for i=1:length(exct)
    k=1;
    for j=1:length(vms)
        
        fid = fopen(strcat(vms{j},'/vic_',vms{j},'_output_',exct{i}));
        try
         tline = fgets(fid);
        catch
         break;
        end

        while (ischar(tline) )
    
            oline = strsplit(strtrim(tline));
            if (length(oline)>1)
                mat(k,i) = str2double(oline(5));
                k=k+1;
            end
            tline = fgets(fid);
        end


               
        
    end
end

xmat=[];

k=1;
for i=1:length(mat)

    xmat=[xmat;vms_name{k}];
    if(mod(i,data_number_per_file)==0)
        k=k+1;
    end
end
xmat_num=zeros(size(mat));
for j = 1:length(exct)
    xmat_num(:,j)=str2double(exct{j});
end

% boxmat=reshape(mat, size(mat,1)*size(mat,2),1);
% boxxmat=reshape(xmat,size(mat,1)*size(mat,2),1);
% boxmat=boxmat./boxxmat;
figure
for i=1:length(exct)
    subplot(2,3,i)
    boxplot(mat(:,i)./xmat_num(:,i),xmat)
    title(strcat('execution time(ms): ',exct{i}))
end

% %%
% % different view of fig 2
% clc
% clear
% close all
% format long;
% data_number_per_file = 27;
% %hp1:xen, hp2:rtxen, hp3:bare-metal
% vms = cellstr(['hp1';'hp2';'hp3']);
% exct =  cellstr(['0.10';'1   ','10  ';'50  ';'100 ';'200 ';'400 ']);
% 
% % machine ='xen';
% 
% 
% mat = zeros(data_number_per_file*length(vms),length(exct));
% schdublilty = zeros(4,8);
% 
% for i=1:length(exct)
%     k=1;
%     for j=1:length(vms)
%         
%         fid = fopen(strcat(vms{j},'/output'));
%         try
%          tline = fgets(fid);
%         catch
%          break;
%         end
% 
%         while (ischar(tline) )
%     
%             oline = strsplit(strtrim(tline));
%             if (length(oline)>1)
%                 mat(k,i) = str2double(oline(5));
%                 k=k+1;
%             end
%             tline = fgets(fid);
%         end
% 
% 
%                
%         
%     end
% end
% % 
% xmat=zeros(size(mat));
% interval = data_number_per_file;
% for j = 1:length(exct)
%     for i=1:length(vms)
%         xmat(1+(i-1)*interval:i*interval,j)= str2double(exct{i})*ones(data_number_per_file,1);
%     end
% 
% end
% boxmat=reshape(mat, size(mat,1)*size(mat,2),1);
% boxxxmat=reshape(xmat,size(mat,1)*size(mat,2),1);
% boxplot(boxmat,boxxmat)
