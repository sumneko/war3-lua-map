local mt = {}

mt.info = {
    name = '导入文件',
    version = 1.0,
    author = '最萌小汐',
    description = '导入底层需要的文件'
}

local function scanDir(dir, callback)
    for path in dir:list_directory() do
        if fs.is_directory(path) then
            scanDir(path, callback)
        else
            callback(path)
        end
    end
end

function mt:on_convert(w2l)
    -- TODO 如果是YDWE打开lni地图，则不执行以下代码
    if w2l.setting.mode == 'obj' and w2l.log_path:filename():string() == 'w3x2lni' then
        return
    end
    if w2l.setting.mode == 'lni' then
        return
    end
    if w2l.input_mode ~= 'lni' then
        return
    end

    local basePath = w2l.setting.input / 'w3x2lni' / 'import'
    local baseLen = #basePath:string()
    scanDir(basePath, function (path)
        local related = path:string():sub(baseLen + 2)
        w2l:file_save('map', related, io.load(path))
    end)
end

return mt
