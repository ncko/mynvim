------------
-- Gitsigns has a lot of interesting features that are worth exploring
-- - works with hunks (stage, reset, etc
-- - preview windows for git changes
-- - blames
-- - diff changes in a side-by-side window ('vimdiff')
------------


return {
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				local gitsigns = require('gitsigns')

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal({ ']c', bang = true })
					else
						gitsigns.nav_hunk('next')
					end
				end)

				map('n', '[c', function()
					if vim.wo.diff then
					vim.cmd.normal({ '[c', bang = true })
					else
						gitsigns.nav_hunk('prev')
					end
				end)

				--map('n', '<leader>gsh', gitsigns.stage_hunk, { desc = '[G]it [S]tage [H]unk' })
				--map('n', '<leader>gush', gitsigns.undo_stage_hunk, { desc = '[G]it [U]ndo [S]tage [H]unk' })
				--map('n', '<leader>gsb', gitsigns.stage_buffer, { desc = '[G]it [S]tage [B]uffer' })
				--map('n', '<leader>gph', gitsigns.preview_hunk, { desc = '[G]it [P]review [H]unk' })
				--map('n', '<leader>gbl', function() gitsigns.blame_line{full=true} end, { desc = '[G]it [Bl]ame' })
				--map('n', '<leader>gdt', gitsigns.diffthis, { desc = '[G]it [D]iff [T]his' })
			end
		}
	}
}
