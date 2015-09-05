function [confusionMatrix, classes] = plotConfusionMatrix(trueLabels, predictedLabels)
%Generate confusion matrix and plot the result

    [confusionMatrix, classes] = confusionmat(trueLabels, predictedLabels);
    confusionMat = confusionMatrix ./ repmat(sum(confusionMatrix, 2), 1, size(confusionMatrix, 2));
    %Percentage
    confusionMat = confusionMat * 100;

    %Create a colored plot of the matrix values
    figure; imagesc(confusionMat); 
    
    title('Confusion Matrix');
    %Determine the color scheme gray (so higher values are black and lower values are white)
    colormap(flipud(gray));
    
    %Create strings from the matrix values and remove whitespaces
    textStrings = num2str(confusionMat(:),'%0.2f');  
    textStrings = strtrim(cellstr(textStrings));  
    
    [x, y] = meshgrid(1:length(classes));
    %Plot the strings
    hStrings = text(x(:), y(:), textStrings(:), ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 14);
            
    % Get the middle value of the color rang
    midValue = mean(get(gca,'CLim'));  
    
    %Choose white or black for thetext color
    textColors = repmat(confusionMat(:) > midValue,1, 3);  
    %Change the text colors
    set(hStrings,{'Color'}, num2cell(textColors, 2));  

    set(gca, ...
        'FontWeight','bold', ...
        'FontSize', 12, ...
        'XTick', 1:length(classes), ...                         
        'XTickLabel', classes,... 
        'YTick', 1:length(classes), ...
        'YTickLabel', classes, ...
        'TickLength', [0 0]);
end