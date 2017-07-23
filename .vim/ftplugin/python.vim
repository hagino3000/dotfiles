" PEP 8 Indent rule
setl tabstop=8
setl softtabstop=4
setl shiftwidth=4
setl smarttab
setl expandtab
setl autoindent
setl nosmartindent
setl cindent
setl textwidth=120

" Folding
setl foldmethod=indent
setl foldlevel=99

" Use virtualenv python
let g:pythonworkon = "System"
py3 << EOF
import sys, os.path
import vim

def append_sys_path(target_dir):
    if os.path.exists(target_dir):
        sys.path.append(target_dir)

project_base_dir = None

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    if os.path.exists(activate_this):
        execfile(activate_this, dict(__file__=activate_this))

    sys.path.insert(0, os.getcwd())
    append_sys_path(os.path.join(project_base_dir, 'lib64/python3.6/site-packages'))
    append_sys_path(os.path.join(project_base_dir, 'lib64/python3.5/site-packages'))
    append_sys_path(os.path.join(project_base_dir, 'lib64/python2.7/site-packages'))
    append_sys_path(os.path.join(project_base_dir, 'lib/python3.6/site-packages'))
    append_sys_path(os.path.join(project_base_dir, 'lib/python3.5/site-packages'))
    append_sys_path(os.path.join(project_base_dir, 'lib/python2.7/site-packages'))

if project_base_dir:
    # Save virtual environment name to VIM variable
    vim.command("let g:pythonworkon = '%s'" % os.path.basename(project_base_dir))
    # ref.vim
    vim.command("if !exists('g:ref_pydoc_cmd') | let g:ref_pydoc_cmd = 'python -m pydoc' | endif")

EOF
let &statusline="%F%m%r%h%w\ [%{&ff}][%{&fenc!=''?&fenc:&enc}][%Y][pos:%04l,%04v][rows:%L] %= [WORKON=%{pythonworkon}]"
