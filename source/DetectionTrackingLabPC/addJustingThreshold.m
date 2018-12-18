function [bbX, bbY, midX, midY, bbWidth, bbheight] = addJustingThreshold(boundingBox)

  bbWidth = boundingBox(3, 1);
  bbheight = boundingBox(4, 1);
  bbX = boundingBox(1, 1);
  bbY = boundingBox(2, 1);
  bbY = bbY - (bbheight/2);
  bbWidth = bbWidth - 5;
  bbheight = bbheight + (bbheight/2);
  midX = bbX+(bbWidth/2);
  midY = bbY + (bbheight/2);
  
end