classdef BM < handle
    %BM Benchmark class
    
    properties
        generator;
        root;
        current;
    end
    
    methods
        function obj = BM(generator)
            obj.generator = generator;
            obj.root = fullfile(bm.root(), generator);
            obj.current = obj.root;
        end
        
        function open(obj)
            if ~isfolder(obj.current)
                mkdir(obj.current);      
            end      
        end
        
        function export(obj, key, content)
            obj.open();
            target = fullfile(obj.current, sprintf('%s.mat', key));
            if isfile(target) 
                delete(target);
            end
            save(target, 'content');
        end
        
        function exports(obj, key, content)
            obj.open();
            target = fullfile(obj.current, sprintf('%s.txt', key));
            f = fopen(target, 'w');
            fprintf(f, content);
            fclose(f);
        end
        
        function res = exec(obj, method, params)
            bm.textprogressbar(); % clear progress bar state
            bm.textprogressbar(sprintf('executing method: %s -- ', char(method)));
            res = [];
            for i=1:length(params)
                bm.textprogressbar((i/length(params))*100);
                obj.current = fullfile(obj.root, sprintf('result-%03d', i));
                [log, out] = evalc('method(obj, params(i))');
                if ~isempty(log)
                    obj.exports('log', log);
                end
                res = [res, out]; % expected signature (bm, struct).
            end          
            bm.textprogressbar(' done');
            obj.current = obj.root;
            obj.export('table', res);
            
            res = bm.BMResult(obj.generator);
        end
    end
end

