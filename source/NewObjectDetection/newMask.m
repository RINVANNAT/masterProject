function frame = newMask (stateVectorPrediction, img, point_)


w =stateVectorPrediction(3,1)/2;
h = stateVectorPrediction(4,1)/2;
midh = ceil(h);
midw = ceil(w);
x = ceil( stateVectorPrediction(1,1) );
y = ceil( stateVectorPrediction(2,1) );
sub_result = zeros(size(img, 1), size(img, 2));

p1 = [x, point_(1,2)-5];
p2 = [(x-midw),(y + midh) ];
p3 = [(x+midw)-5, (y + midh)];
% imshow(img);
% hold on
% 
% plot( x, point_(1,2), 'c*', 'LineWidth',2);
% figure();


%     for i= ceil(point_(1,2))+2 :(y + midh) % throw y
%        for j=(x-midw):(x+midw) % throw x
%            
%            checkPoint = [j,i];
%            trueValue = checkComponent(p3, p2, p1, checkPoint);
%            if (trueValue == 1)
%                sub_result(i, j) = 1 ;
%            end 
%             
%         end
%                  
%    end




 sub_result( (y - midh)+3:(y + midh)-3, (x-midw): (x+midw)-12)= 1;
frame = (sub_result);


end