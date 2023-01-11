;; -*- lexical-binding: t; -*-


(d:module
 '((packages cmake-mode
             dockerfile-mode
             haskell-mode
             json-mode
             markdown-preview-mode
             meson-mode
             nix-mode
             pkgbuild-mode
             popwin
             rust-mode
             solidity-mode
             typescript-mode
             yaml-mode
             yasnippet-snippets

             ;; Needed by library/interactives.el .
             projectile

             ;;
             ;; Not sure if I should add them on all machines as it's
             ;; damn painful to run vterm on NixOS:
             ;;
             ;; 1. Install vterm and vterm-toggle (done by this file).
             ;;
             ;; 2. cd ~/.emacs.d/elpa/vterm-*
             ;;
             ;; 3. $ sed -i.bak 's/libvterm\.a/libvterm\.so/' CMakeLists.txt
             ;;
             ;; 4. $ mkdir build && cd build && cmake .. && make
             ;;
             ;; 5. $ find . -name 'libvterm.so.0'  # It's a symlink!
             ;;
             ;; 6. Copy libvterm.so.0 somewhere in $LD_LIBRARY_PATH.
             ;;
             vterm
             vterm-toggle)))


(provide 'd-packages)
