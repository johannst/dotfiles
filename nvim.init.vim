" dotfiles -- nvim.init.vim.experimental
" author: johannst

let mapleader=" "

" -----------------
" Plugins.
" -----------------

" Install vim-plug for neivom
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
call plug#begin('~/.nvim/plugged')
    " Colors.
    Plug 'chriskempson/base16-vim'

    " LSP.
    Plug 'neovim/nvim-lspconfig'
    " Completion framework.
    Plug 'hrsh7th/nvim-cmp'
    " Completion sources.
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'hrsh7th/cmp-buffer'
    "Plug 'hrsh7th/cmp-path'
    "Plug 'hrsh7th/cmp-cmdline'

    " Telescope.
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
call plug#end()

" -----------------
" Setters.
" -----------------

"set termguicolors
set background=dark
"colorscheme base16-default-dark
"colorscheme base16-onedark
highlight Pmenu    ctermbg=DarkGray guibg=DarkGrey
highlight PmenuSel ctermfg=Black guifg=Black ctermbg=LightGray guibg=LightGray

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

set completeopt=menuone,noselect

lua << EOF

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer' },
  --  { name = 'path' }
  }),
  experimental = {
    ghost_text = true
  },
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Disable LSP snippet completion.
capabilities.textDocument.completion.completionItem.snippetSupport = false
--print(vim.inspect(capabilities))

local on_attach = function(client, bufnr)
    -- Install `omnifunc` completion handler, get completion with <C-x><C-o>.
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Disable LSP highlighting.
    client.server_capabilities.semanticTokensProvider = nil
end

-- Setup rust-analyzer.
require'lspconfig'.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Setup clangd.
require'lspconfig'.clangd.setup {
    cmd = { "clangd", "--background-index", "--completion-style=detailed" },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Setup pyright.
require'lspconfig'.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

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

" LSP
nnoremap <silent> <C-]>         <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> <leader><C-]> <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <C-k>         <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> <leader>r     <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> <leader>i     <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <leader>f     <cmd>lua vim.lsp.buf.format()<cr>
nnoremap <silent> <leader>a     <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> <leader>n     <cmd>lua vim.lsp.buf.rename()<cr>

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
