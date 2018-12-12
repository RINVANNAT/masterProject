function [Isup]=nonmaximalsupression(I,theta)

%     [a1 b1]= size(theta);
%     Isup=zeros([a1 b1]);
     I = padarray(I, [1 1]);
     [a, b]=size(theta);
    for i=2:a-2
        for j=2:b-2
            
            
            
            
%            if (theta(i,j)  == 0)
%                  
%                  if ((I(i-1,j+1)>I(i,j))||(I(i+1,j-1)>I(i,j)))
%                      I(i,j)=0;
%                  end
%            elseif (theta(i,j)  == 1 )
%                 if ((I(i-1,j+1)>I(i,j))||(I(i+1,j-1)>I(i,j)))
%                          I(i,j)=0;
%                 end     
%            elseif (theta(i,j)  == 2 )
%                if ((I(i-1,j+1)>I(i,j))||(I(i+1,j-1)>I(i,j)))
%                         I(i,j)=0;
%                end
%            elseif (theta(i,j)  == 3 )
%                if ((I(i-1,j+1)>I(i,j))||(I(i+1,j-1)>I(i,j)))
%                         I(i,j)=0;
%                end
%            elseif (theta(i,j)  == 4 )
%                I(i,j)=0;
%            elseif (theta(i,j)  == 5 )
%                I(i,j)=0;
%            elseif (theta(i,j)  == 6 )
% %                I(i,j)=0;
%            elseif (theta(i,j)  == 7 )
% %                I(i,j)=0;
%            elseif (theta(i,j)  == 8 )
% %                I(i,j)=0;
%            elseif (theta(i,j)  == 9 )
% %                I(i,j)=0;
%            elseif (theta(i,j)  == 10 )
% %                if ((I(i-1,j+1)>I(i,j))||(I(i+1,j-1)>I(i,j)))
% %                         I(i,j)=0;
% %                end
%            elseif (theta(i,j)  == 11 )
% %                if ((I(i-1,j+1)>I(i,j))||(I(i+1,j-1)>I(i,j)))
% %                         I(i,j)=0;
% %                end
%            elseif (theta(i,j)  == 12 )
%                I(i,j)=0;
%            elseif (theta(i,j)  == 13 )
%                I(i,j)=0;
%            elseif (theta(i,j)  == 14 )
%                I(i,j)=0;
%            elseif (theta(i,j)  == 15 )
%                I(i,j)=0;
%            elseif (theta(i,j)  == 16 )
%                I(i,j)=0;
%            elseif (theta(i,j)  == 17 )
%                I(i,j)=0;
%            else
%                I(i,j)=0;
%            end

            if (theta(i,j)==135)
%                  I(i,j)=0;
                    if ((I(i-1,j+1)>I(i,j))||(I(i+1,j-1)>I(i,j)))
                        I(i,j)=0;
                    end
            elseif (theta(i,j)==45)   
%               I(i,j)=0;
                     if ((I(i+1,j+1)>I(i,j))||(I(i-1,j-1)>I(i,j)))
                          I(i,j)=0;
                     end
            elseif (theta(i,j)==90)   
%                  I(i,j)=0;
%                    if ((I(i,j+1)>I(i,j))||(I(i,j-1)>I(i,j)))
%                        I(i,j)=0;
%                    end
            elseif (theta(i,j)==0)   
% %                 I(i,j)=0;
%                    if ((I(i+1,j)>I(i,j))||(I(i-1,j)>I(i,j)))
%                        
%                    end
           end
        end
    end
    Isup=I;
    
    
    
    
    
end