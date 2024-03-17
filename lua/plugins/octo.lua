return
{
    'pwntester/octo.nvim',
    dependecies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        -- OR 'ibhagwan/fzf-lua',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require "octo".setup()
        register_mapping({
            n = {
                ["<Leader>O"] = {
                    name = "Octo",
                    p = { "<cmd>Octo pr list<cr>", "PR List" },
                    c = { "<cmd>Octo pr create<cr>", "PR List" },
                }
            }
        })
    end
}
