" dotfiles -- nvim.init.vim.experimental
" author: johannst

let mapleader=" "

" -----------------
" Plugins.
" -----------------

call plug#begin('~/.nvim/plugged')
    " Colors.
    Plug 'chriskempson/base16-vim'

    " LSP & Completion.
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'

    " Telescope.
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
call plug#end()

" -----------------
" Setters.
" -----------------

set termguicolors
set background=dark
colorscheme base16-default-dark

set relativenumber
set number
set signcolumn=yes

set mouse=a
set scrolloff=8

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set expandtab

set list
set listchars=tab:>-,trail:-

set hidden
set nobackup
set noswapfile

set hlsearch
set incsearch

set nowrap

if executable('rg')
    set grepprg=rg\ --vimgrep
endif

" -----------------
" LSP & Complete.
" -----------------

"set completeopt=menuone,noinsert,noselect

lua << EOF
local on_attach = function(_client, bufnr)
    -- Install `omnifunc` completion handler, get completion with <C-x><C-o>.
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Key mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>i", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Setup rust-analyzer.
require'lspconfig'.rust_analyzer.setup {
    on_attach = on_attach,
}

-- Setup clangd.
require'lspconfig'.clangd.setup {
    cmd = { "clangd", "--background-index", "--completion-style=detailed" },
    on_attach = on_attach,
}

-- Setup pyright.
require'lspconfig'.pyright.setup {
    on_attach = on_attach,
}

-- Setup nvim-compe.
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = false;
    calc = false;
    nvim_lsp = true;
    nvim_lua = false;
    vsnip = false;
    ultisnips = false;
  };
}

vim.o.completeopt = "menuone,noselect"

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true})
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", {expr = true})

-- Telescope.
local picker_cfg = { theme = "ivy" }

require('telescope').setup{
  pickers = {
    buffers     = picker_cfg,
    find_files  = picker_cfg,
    man_pages   = picker_cfg,
  },
}
-- Telescope: load fzf-native.
require('telescope').load_extension('fzf')
EOF

" -----------------
" Mappings.
" -----------------

vnoremap <leader>p "_dP

" Telescope
nnoremap <leader>fb  <cmd>Telescope buffers<cr>
nnoremap <leader>ff  <cmd>Telescope find_files<cr>
nnoremap <leader>fe  <cmd>Telescope file_browser<cr>
nnoremap <leader>fg  <cmd>Telescope live_grep<cr>
nnoremap <leader>fm  <cmd>Telescope man_pages sections={"2","3"}<cr>
nnoremap <leader>ft  <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fwt <cmd>Telescope lsp_dynamic_workspace_symbols<cr>

" -----------------
" Autogroups.
" -----------------

augroup AG_highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 300})
augroup END

" vim:ft=vim
