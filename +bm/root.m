function res = root(dir)
    if ~ispref('bm', 'output')
        addpref('bm', 'output', 'output');
    end
    if exist('dir', 'var')
        setpref('bm', 'output', dir);
    end
    res = getpref('bm', 'output');
    if ~isfolder(res)
        mkdir(res)
    end
end