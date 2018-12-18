function [theta]=computeangle(IGradX,IGradY)


        [a,b]=size(IGradX);
        
        theta=zeros([a b]);
        
        for i=1:a
            
          for j=1:b
                if(IGradX(i,j)==0)
                   theta(i,j)= atan(IGradY(i,j)/0.000000000001);
                else
                    theta(i,j)=atan(IGradY(i,j)/IGradX(i,j));
                end
          end
          
        end
       theta=theta*(180/3.14);
       for i=1:a
           
         for j=1:b
             if(theta(i,j)<0)
                theta(i,j)= theta(i,j)-90;
                theta(i,j)=abs(theta(i,j));
             end
         end
         
       end
       
       for i=1:a
           
          for j=1:b
              
              
%               if ((0<theta(i,j))&&(theta(i,j)<10))
%                    theta(i,j)=0;
%               elseif (10 <theta(i,j)) && (theta(i,j)< 20)
%                   theta(i,j)=1;
%               elseif (20 <theta(i,j))&&(theta(i,j)< 30)
%                   theta(i,j)=2;
%               elseif (30 <theta(i,j))&&(theta(i,j)< 40)
%                   theta(i,j)=3;
%               elseif (40 <theta(i,j))&&(theta(i,j)<50)
%                   theta(i,j)=4;
%               elseif (50<theta(i,j))&&(theta(i,j)<60)
%                   theta(i,j)=5;
%               elseif (60<theta(i,j))&&(theta(i,j)<70)
%                   theta(i,j)=6;
%               elseif (70<theta(i,j))&&(theta(i,j)<80)
%                     theta(i,j)=7;
%               elseif (80<theta(i,j))&&(theta(i,j)<90)
%                   theta(i,j)=8;
%               elseif (90<theta(i,j))&&(theta(i,j)<100)
%                   theta(i,j)=9;
%               elseif (100<theta(i,j))&&(theta(i,j)<110)
%                   theta(i,j)=10;
%               elseif (110<theta(i,j))&&(theta(i,j)<120)
%                   theta(i,j)=11;
%               elseif (120<theta(i,j))&&(theta(i,j)<130)
%                  theta(i,j)=12;
%               elseif (130<theta(i,j))&&(theta(i,j)<140)
%                  theta(i,j)=13;
%              elseif (140<theta(i,j))&&(theta(i,j)<150)
%                     theta(i,j)=14;
%              elseif (150<theta(i,j))&&(theta(i,j)<160)
%                      theta(i,j)=15;
%              elseif (160<theta(i,j))&&(theta(i,j)<170)
%                     theta(i,j)=16;
%               elseif ((170<theta(i,j))&&(theta(i,j)<181))
%                   theta(i,j)=17;
%               end
              
               if ((0<theta(i,j))&&(theta(i,j)<25.5))||((157.5<theta(i,j))&&(theta(i,j)<181))
                   
                     theta(i,j)=0;
                     
               elseif (22.5<theta(i,j))&&(theta(i,j)<67.5)
                   
                      theta(i,j)=45;
                      
               elseif (67.5<theta(i,j))&&(theta(i,j)<112.5)  
                   
                       theta(i,j)=90;
                       
               elseif (112.5<theta(i,j))&&(theta(i,j)<157.5)
                   
                       theta(i,j)=135;
                       
               end
              
          end
          
       end 
       
       
       
end