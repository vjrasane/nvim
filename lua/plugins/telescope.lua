local actions    = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin    = require('telescope.builtin')
local icons      = require('utils.icons')

require('telescope').load_extension('fzf')
require('telescope').load_extension('repo')
require("telescope").load_extension("git_worktree")

local git_icons = {
	added = icons.gitAdd,
	changed = icons.gitChange,
	copied = ">",
	deleted = icons.gitRemove,
	renamed = "➡",
	unmerged = "‡",
	untracked = "?",
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
	defaults = {
		border               = true,
		hl_result_eol        = true,
		multi_icon           = '',
		vimgrep_arguments    = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		layout_config        = {
			horizontal = {
				preview_cutoff = 120,
			},
			prompt_position = "bottom",
		},
		file_sorter          = require('telescope.sorters').get_fzy_sorter,
		prompt_prefix        = '  ',
		color_devicons       = true,
		git_icons            = git_icons,
		sorting_strategy     = "ascending",
		file_previewer       = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer       = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer     = require('telescope.previewers').vim_buffer_qflist.new,
		file_ignore_patterns = {
			"node_modules"
		},
		mappings             = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
				['<C-c>'] = require("telescope.actions").close,
				['<esc>'] = require("telescope.actions").close,
			},
			n = {
			},
		},
	},
	extensions = {
		fzf = {
			override_generic_sorter = false,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	}
}

-- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sp', function()
	require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = '[S]earch [P]roject' })
