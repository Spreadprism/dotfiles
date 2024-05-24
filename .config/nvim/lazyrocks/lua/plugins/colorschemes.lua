local transparent = plugin("xiyaowong/transparent.nvim"):lazy(false)

plugin("folke/tokyonight.nvim"):lazy(false):priority(1000):dependencies(transparent):config("colorscheme")
