-- Set up LSP keymaps when an LSP client attaches
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    -- Buffer local mappings
    local opts = { buffer = args.buf, remap = false }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- List references

    -- Information
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Show hover information
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Show signature help

    -- Code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Trigger code actions
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol

    -- Diagnostics
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts) -- Next diagnostic
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts) -- Show diagnostic details
  end,
})
