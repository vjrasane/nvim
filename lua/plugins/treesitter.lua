-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	require('nvim-treesitter.configs').setup {
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = {
			'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc',
			'vim',
			'bash', "html",
			"css",
			"vue",
			"astro",
			"svelte",
			"gitcommit",
			"graphql",
			"json",
			"json5",
			"lua",
			"markdown",
			"prisma", },
		sync_install = false,
		ignore_install = { "haskell" },
		-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<c-space>',
				node_incremental = '<c-space>',
				scope_incremental = '<c-s>',
				node_decremental = '<M-space>',
			},
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
					['it'] = '@tag.inner',
					['at'] = '@tag.outer',
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']F'] = '@function.outer',
					[']C'] = '@class.outer',
					-- [']T'] = '@tag.outer',
				},
				goto_next_end = {
					[']f'] = '@function.outer',
					[']c'] = '@class.outer',
					-- [']t'] = '@tag.outer',
				},
				goto_previous_start = {
					['[F'] = '@function.outer',
					['[C'] = '@class.outer',
					-- ['[T'] = '@tag.outer',
				},
				goto_previous_end = {
					['[f'] = '@function.outer',
					['[c'] = '@class.outer',
					-- ['[t'] = '@tag.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					--    ['<leader>a'] = '@parameter.inner',
				},
				swap_previous = {
					--   ['<leader>A'] = '@parameter.inner',
				},
			},
		},
		textsubjects = {
			enabled = true,
			keymaps = {
				['<cr>'] = 'textsubjects-smart',
			}
		},
		autotag = {
			enabled = true
		}
	}
end, 0)
