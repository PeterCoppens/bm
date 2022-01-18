classdef BMResult < handle
    properties
        root;
        table;
    end
    
    methods
        function obj = BMResult(generator)
            obj.root = fullfile(bm.root(), generator);
        end
        
        function res = get.table(obj)
            res = load(fullfile(obj.root, 'table.mat')).content;            
        end
        
        function res = load(obj, key, idx)
            dir = sprintf('result-%03d', idx);
            file = sprintf('%s.mat', key);
            target = fullfile(obj.root, dir, file);
            res = load(target).content;
        end
    end
end

