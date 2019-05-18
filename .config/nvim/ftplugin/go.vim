set tabstop=4
let g:go_fmt_command = "goimports"
let g:ale_linters = {'go': ['golangci-lint']}
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = '--fast'
