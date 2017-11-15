function rgbMap = colorMapGenerator()
    hsvMap = linspace( 0, 1, 99)';
    hsvMap(:, 2) = 0.5;
    hsvMap(:, 3) = 1;
    rgbMap = hsv2rgb(hsvMap);
    rgbMap = [ 0.2 0.2 0.2 ; rgbMap ];
    size(rgbMap)
end

