function writeSolution(iterTable, header, fileName)
dataTable = array2table(iterTable,'VariableNames', header);
writetable(dataTable, fileName);
end