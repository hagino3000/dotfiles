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
py << EOF
import sys, os.path
import vim
import commands

project_base_dir = None
venv_python = commands.getoutput("pyenv which python")

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    if os.path.exists(activate_this):
        execfile(activate_this, dict(__file__=activate_this))

elif venv_python.find('/bin/python') != -1:
    python_path = venv_python.partition('/bin/python')[0]
    project_base_dir = python_path
    sys.path.insert(0, project_base_dir)
    sys.path.insert(0, project_base_dir + '/lib/python2.7/site-packages')

if project_base_dir:
    # Save virtual environment name to VIM variable
    vim.command("let g:pythonworkon = '%s'" % os.path.basename(project_base_dir))

    # ref.vim
    vim.command("if !exists('g:ref_pydoc_cmd') | let g:ref_pydoc_cmd = 'python -m pydoc' | endif")

EOF
let &statusline="%F%m%r%h%w\ [%{&ff}][%{&fenc!=''?&fenc:&enc}][%Y][pos:%04l,%04v][rows:%L] %= [WORKON=%{pythonworkon}]"
