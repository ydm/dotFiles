;;-*-coding: utf-8;-*-

(define-abbrev-table 'Buffer-menu-mode-abbrev-table '())

(define-abbrev-table 'change-log-mode-abbrev-table '())

(define-abbrev-table 'comint-mode-abbrev-table '())

(define-abbrev-table 'completion-list-mode-abbrev-table '())

(define-abbrev-table 'emacs-lisp-byte-code-mode-abbrev-table '())

(define-abbrev-table 'emacs-lisp-mode-abbrev-table '())

(define-abbrev-table 'fundamental-mode-abbrev-table '())

(define-abbrev-table 'global-abbrev-table
  '(
    ("1alpha" "α")
    ("1beta" "β")
    ("1delta" "Δ")
    ("1lambda" "λ")
    ("1phi" "φ")
    ("1coding" "-*- coding: utf-8 -*-")
    ("1copyright" "©")
    ("1interpunct" "·")
    ("1runhs" "#!/usr/bin/env runhaskell")

    ;; Python specific abbreviations (python-mode-abbrev-table doesn't work...)
    ("1ubinenv" "#!/usr/bin/env python")
    ("1ubinenv2" "#!/usr/bin/env python2")
    ("1ubinenv3" "#!/usr/bin/env python3")
    ("1pdb" "import pdb; pdb.set_trace()")
    ("1unilit" "from __future__ import unicode_literals")
    ("1printfunc" "from __future__ import print_function")
    ("1ifmain" "if __name__ == '__main__':\n    main()" nil 2)
    ("1stack" "import traceback; traceback.print_stack()")
   ))

(define-abbrev-table 'inferior-python-mode-abbrev-table '())

(define-abbrev-table 'lisp-mode-abbrev-table '())

(define-abbrev-table 'occur-edit-mode-abbrev-table '())

(define-abbrev-table 'occur-mode-abbrev-table '())

(define-abbrev-table 'package-menu-mode-abbrev-table '())

(define-abbrev-table 'process-menu-mode-abbrev-table '())

(define-abbrev-table 'prog-mode-abbrev-table '())

(define-abbrev-table 'python-mode-abbrev-table '())

(define-abbrev-table 'special-mode-abbrev-table '())

(define-abbrev-table 'tabulated-list-mode-abbrev-table '())

(define-abbrev-table 'text-mode-abbrev-table '())
