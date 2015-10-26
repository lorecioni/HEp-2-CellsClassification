function labels = num2classes(nums)
%Returns correspective labels from class numbers
    labels = cell(length(nums), 1);    
    for i = 1:length(nums)
           labels{i} = configuration.patterns(nums(i));
    end
end

