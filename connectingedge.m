function [Ifinal]=connectingedge(Ie1,Th,Tl)

    [a b]= size(Ie1);
    
    Ifinal=zeros([a b]);
    
    for i=1:a
        
        for j=1:b
            
            if (Ie1(i,j) > Th)
                
                Ifinal(i,j)= Ie1(i,j);
%===============checking connectivities of edge=========================
                % ==== this is 8 connected edge===
                  for i2=(i-1):(i+1)
                      
                      for j2= (j-1):(j+1)
                          
                          if (Ie1(i2,j2)>Tl)&&(Ie1(i2,j2)<Th)
                              
                              Ifinal(i2,j2)=Ie1(i,j);
                              
                          end
                          
                      end
                      
                  end
                 
                 % ====end of 8 connection===================
                 
                 
                 %===== this is 4 connected edge algorithm===
%                  c_i = i; % current i
%                  c_j = j; % current j
%                  for i2=(i-1):(i+1)
%                      
%                      for j2= (j-1):(j+1)
%                          
%                          if j2 == (c_j)
%                              if (Ie1(i2,j2)>Tl)&&(Ie1(i2,j2)<Th)
%                                 Ifinal(i2,j2)=Ie1(i,j);
%                              end
%                          end
%                          
%                          if i2 == c_i
%                              if j2 ~= c_j
%                                  if (Ie1(i2,j2)>Tl)&&(Ie1(i2,j2)<Th)
%                                     Ifinal(i2,j2)=Ie1(i,j);
%                                  end
%                              end
%                          end 
%                          
%                      end
%                      
%                  end
                 %===== end of 4 connection==================
%=============== end of checking edge connectivities =========================
                 
            end
            
        end
        
    end
    
end