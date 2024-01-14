return {
	"takac/vim-hardtime",
	init = function()
		vim.cmd("let g:hardtime_maxcount = 3")
		vim.cmd("let g:hardtime_motion_with_count_resets = 1")
		vim.cmd("let g:hardtime_showmsg = 1")
		vim.cmd("let g:hardtime_default_on = 1")
		-- vim.cmd('let g:hardtime_allow_different_key = 1')
	end,
	lazy = true,
}
