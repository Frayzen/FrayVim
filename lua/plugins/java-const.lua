return {
    'artur-shaik/jc.nvim',
    config = function ()
        require('jc').setup({});
        register_mapping({
            n = {
                ["<Leader>jc"] = { "<cmd>JCgenerateConstructor<CR>", "Generate java constructor" },
            },
        });
    end
}
