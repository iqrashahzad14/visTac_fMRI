%This function plot values in a dot plot style, in which  values that are close to each other (according
% to the selected density_distance)are plotted as a single marker. 
% The size of the marker increases according to the number of the values that it represents

function [new_vec,size]=compute_density(col,density_distance,starting_size);
 %%col = the data you want to plot for one condition in column format 
 %%density_distance = if the difference of 2 values is equal or smaller
 %%than the density distance the 2 values will be represented as one
 %%marker.
 %%OUTPUT:
 %%new_vec=new column of value in which close values have been averaged
 %%size=how many values are averaged in each cluster
 

 
colSORT=sort(col,'descend'); %order the column values from bigger to smaller
    counter=1;
    density_code=zeros(length(col),1);
    density_code(1)=counter;
    for i=1:length(colSORT)-1 %for i number of element in each column
        d=colSORT(i)-colSORT(i+1); %compute the distance (=difference) with the closest value
        if d<=density_distance %if the distance is equal or smaller than the given density distance 
            density_code(i+1)=counter; %the 2 values will be clustered together
        elseif d>density_distance %if the distance is bigger than the given density distance 
            density_code(i+1)=counter+1; %the 2 values will NOT be clustered together
            counter=counter+1;
        end %if loop
    end %for i number of element in each column
    

cluster_density=unique(density_code); 
for i_cluster=1:length(cluster_density)
    idx= (density_code==i_cluster);
    new_vec(i_cluster,1)=mean(colSORT(idx)); %averaged together the values that will be clustered together and represented in one marker
    size(i_cluster,1)= starting_size * (sum(idx==1)); %find how many values are clustered together to assign the correct size to the marker 
end %for i_cluster