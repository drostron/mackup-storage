;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     better-defaults
     col-highlight
     emacs-lisp
     git
     github
     haskell
     helm
     html
     idris
     javascript
     lua
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     ;; org
     osx
     purescript
     python
     rust
     scala
     (shell :variables
            shell-default-position 'bottom
            shell-default-height 30)
     shell-scripts
     spell-checking
     sql
     ;; syntax-checking
     (version-control :variables
                      version-control-global-margin t)
     yaml
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     ;; dante
     etags-select
     helm-xref
     region-convert
     nix-mode
     protobuf-mode
     )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'hybrid
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         spacemacs-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Iosevka"
                                :size 11
                                :weight normal
                                :width normal
                                :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "C-s-SPC"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  ;; Prevent conflict with desired nix populated PATH when running emacs from nix-shell
  ;; Revisit when emacs start method is brushed up
  (setq exec-path-from-shell-variables nil)

  ;; Roll with aspell over ispell due to nix package install/compilation error for ispall
  (setq ispell-program-name "aspell")
  ;; From https://www.emacswiki.org/emacs/FlySpell#toc8
  (setq ispell-list-command "--list")
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; A few key bindings
  (global-set-key (kbd "s-<up>") 'scroll-down-line)
  (global-set-key (kbd "s-<down>") 'scroll-up-line)
  (global-set-key (kbd "M-S-<up>") (lambda () (interactive) (evil-previous-line 5)))
  (global-set-key (kbd "M-S-<down>") (lambda () (interactive) (evil-next-line 5)))
  (global-set-key (kbd "s-S-<up>") (lambda () (interactive) (scroll-down-line 5)))
  (global-set-key (kbd "s-S-<down>") (lambda () (interactive) (scroll-up-line 5)))
  (global-set-key (kbd "s-F") 'isearch-backward)
  (global-set-key (kbd "s-G") 'isearch-repeat-backward)
  ;; Too close to evil-insert-digraph's C-k
  (global-unset-key (kbd "s-k"))
  ;; A more useful evil-insert-digraph for evil hybrid mode
  (global-set-key (kbd "C-<tab>") 'evil-insert-digraph)
  ;; Prevent evil-insert-digraph from taking over TAB. Too aggressive?
  (global-set-key (kbd "TAB") 'ensime-company-complete-or-indent)
  ;; Add familiar command left and right for beginning and end of line
  (global-set-key (kbd "s-<left>") 'move-beginning-of-line)
  (global-set-key (kbd "s-<right>") 'move-end-of-line)
  ;; Add familiar end of line
  (define-key evil-visual-state-map (kbd "C-a") 'mwim-beginning-of-code-or-line)
  (define-key evil-normal-state-map (kbd "C-e") 'mwim-end-of-line-or-code)
  (define-key evil-visual-state-map (kbd "C-e") 'mwim-end-of-line-or-code)
  ;; Additional evil-escape
  (global-set-key (kbd "C-g") 'evil-escape)
  ;; Hybrid (as in Vim mode) — execute next command in normal state
  (define-key evil-hybrid-state-map (kbd "C-o") 'evil-execute-in-normal-state)
  ;; A more familiar backward and forward jump (sort of)
  (define-key evil-normal-state-map (kbd "M-<up>") 'evil-jump-backward)
  (define-key evil-normal-state-map (kbd "M-<down>") 'evil-jump-forward)
  (define-key evil-hybrid-state-map (kbd "M-<up>") 'evil-jump-backward)
  (define-key evil-hybrid-state-map (kbd "M-<down>") 'evil-jump-forward)
  ;; A familiar backward and forward word for markdown mode
  (add-hook 'markdown-mode-hook
            (lambda ()
              (setq word-wrap t)
              (define-key markdown-mode-map (kbd "M-<left>") 'left-word)
              (define-key markdown-mode-map (kbd "M-<right>") 'right-word)))
  ;; A more familiar spelling correction
  (global-set-key (kbd "s-:") 'flyspell-correct-previous-word-generic)
  ;; Follow attempted usage
  (define-key evil-normal-state-map (kbd "C-d") 'delete-char)
  ;; Quicker window selection
  (global-set-key (kbd "C-s-1") 'winum-select-window-1)
  (global-set-key (kbd "C-s-2") 'winum-select-window-2)
  (global-set-key (kbd "C-s-3") 'winum-select-window-3)
  (global-set-key (kbd "C-s-4") 'winum-select-window-4)
  (global-set-key (kbd "C-s-5") 'winum-select-window-5)
  (global-set-key (kbd "C-s-6") 'winum-select-window-6)
  (global-set-key (kbd "C-s-7") 'winum-select-window-7)
  (global-set-key (kbd "C-s-8") 'winum-select-window-8)
  (global-set-key (kbd "C-s-9") 'winum-select-window-9)
  (global-set-key (kbd "C-s-0") 'winum-select-window-0-or-10)
  ;; Quicker workspace selection
  (global-set-key (kbd "C-s-!") 'eyebrowse-switch-to-window-config-1)
  (global-set-key (kbd "C-s-@") 'eyebrowse-switch-to-window-config-2)
  (global-set-key (kbd "C-s-#") 'eyebrowse-switch-to-window-config-3)
  (global-set-key (kbd "C-s-$") 'eyebrowse-switch-to-window-config-4)
  (global-set-key (kbd "C-s-%") 'eyebrowse-switch-to-window-config-5)
  ;; Quicker buffer selection
  (global-set-key (kbd "<C-s-tab>") 'helm-mini)
  ;; Quicker terminal selection
  (global-set-key (kbd "C-s-`") 'helm-switch-to-term)
  ;; Quicker project buffer selection
  (global-set-key (kbd "<C-S-tab>") 'helm-projectile)
  ;; Quicker project terminal selection
  (global-set-key (kbd "C-~") 'helm-projectile-switch-to-term)
  ;; Auxiliary comment lines
  (global-set-key (kbd "M-/") 'spacemacs/comment-or-uncomment-lines)
  (global-set-key (kbd "s-/") 'spacemacs/comment-or-uncomment-lines)
  ;; [WIP] Utilize the improved spacemacs zoom frm font scaling.
  ;; Avoids the undesirable linum gutter expansion from the default spacemacs/scale-*-font bindings.
  ;; TODO Investigate ↑. Something to do with a non-default font or otherwise?
  ;; Well... frame size gets out of sync with screen size when in full screen.
  ;; TODO See about getting linum and fringe to remain unchanged when using spacemacs/scale-*-font?
  ;; Or at least gutter if sufficient.
  (global-set-key (kbd "s-=") 'spacemacs/zoom-frm-in)
  (global-set-key (kbd "s-+") 'spacemacs/zoom-frm-in)
  (global-set-key (kbd "s--") 'spacemacs/zoom-frm-out)
  (global-set-key (kbd "s-0") 'spacemacs/zoom-frm-unzoom)
  ;; [WIP] Provide the familiar reverse history search within terminal
  (global-unset-key (kbd "C-r"))
  (add-hook 'term-mode-hook
            (lambda ()
              (define-key term-raw-map (kbd "C-r") nil)
              ;; From https://github.com/syl20bnr/spacemacs/issues/2345#issuecomment-240634646
              (define-key evil-hybrid-state-map (kbd "C-r")
                                  (lambda ()
                                    (interactive)
                                    (term-send-raw-string "\C-r")))))

  ;; A few term key binding conveniences
  (add-hook 'term-mode-hook
            (lambda ()
              ;; Ensure a familiar page up and down. Looking at you ansi-term.
              (define-key term-raw-map (kbd "<prior>") 'scroll-down-command)
              (define-key term-raw-map (kbd "<next>") 'scroll-up-command)
              ;; A familiar clear buffer
              (define-key term-raw-map (kbd "s-k")
                ;; The subsequent C-l handles additional cases where the terminal
                ;; output is off-screen and doesn't scroll to follow
                (lambda ()
                  (interactive)
                  (comint-clear-buffer)
                  (term-send-raw-string "\C-l")))
              ;; More convenient access to term-char-mode and term-line-mode
              (define-key term-mode-map (kbd "C-c k") 'term-char-mode)
              (define-key term-raw-map (kbd "C-c l") 'term-line-mode)
              ;; A familiar evil-escape
              (define-key term-raw-map (kbd "C-g") 'evil-escape)))

  ;; An expected etags select escape
  ;; TODO etags-select-quit appears to not return focus to previously selected window.
  ;;      Further appears to be it's use of delete-window that doesn't return focus.
  (add-hook 'etags-select-mode-hook
    (lambda()
      (define-key etags-select-mode-map (kbd "C-g") 'etags-select-quit)))

  ;; More convenient term-char-mode and term-line-mode switching sync'd with visual and hybrid mode
  (defun evil-insert-term-mode-augmented (count &optional vcount skip-empty-lines)
    (when (derived-mode-p 'term-mode) (term-char-mode)))
  (advice-add 'evil-insert :after 'evil-insert-term-mode-augmented)
  (defun evil-escape-term-mode-augmented ()
    (when (derived-mode-p 'term-mode) (term-line-mode)))
  (advice-add 'evil-escape :after 'evil-escape-term-mode-augmented)
  ;; Additionally handle evil-escape-key-sequence
  (advice-add 'evil-escape-func :after 'evil-escape-term-mode-augmented)
  ;; And <escape>
  (defun evil-normal-state-term-mode-augmented (&optional arg)
    (when (derived-mode-p 'term-mode) (term-line-mode)))
  (advice-add 'evil-normal-state :after 'evil-normal-state-term-mode-augmented)

  ;; A more familiar multi-select. Might move to evil-iedit-state/iedit-mode
  ;; Not sure why, but including expand-region under
  ;; dotspacemacs-additional-packages doesn't appear to load er/mark-word
  (require 'expand-region)
  (global-set-key (kbd "s-d")
                  (lambda ()
                    (interactive)
                    (cond ((region-active-p)
                           (progn
                             (deactivate-mark)
                             (spacemacs/symbol-highlight)))
                          (t (er/mark-word)))))

  ;; A more familiar column highlight
  ;; `require` needed here instead of within the custom layer for unknown reason
  (require 'col-highlight)
  (global-set-key (kbd "s-C") 'flash-column-highlight)

  ;; Additional and convenient window switching
  (global-set-key (kbd "s-}") 'evil-window-next)
  (global-set-key (kbd "s-{") 'evil-window-prev)
  (global-set-key (kbd "C-{") 'evil-window-left)
  (global-set-key (kbd "C-}") 'evil-window-right)

  ;; todo Appears to be working nicely without adjustment on the latest Emacs
  ;; A more familiar and less jumpy mouse scroll
  ;; TODO A buffer size dependent scroll-amount
  ;; (setq mouse-wheel-scroll-amount '(3))
  ;; (setq mouse-wheel-progressive-speed nil)

  ;; [WIP] A touch of 3 button mouse emulation
  (define-key key-translation-map (kbd "<M-mouse-1>") (kbd "<mouse-2>"))
  (define-key key-translation-map (kbd "<C-mouse-1>") (kbd "<mouse-3>"))

  ;; A more pleasing which-key location
  (setq which-key-side-window-location '(left bottom))

  ;; A few digraph customizations
  (setq evil-digraphs-table-user
        '(
          ((?= ??) . ?\x225f) ;; =? → ≟
          ((?+ ?+) . ?\x22b9) ;; ++ → ⊹
          ((?| ?>) . ?\x25B9) ;; |> → ▹
          ))

  ;; More pleasing powerline separators, 'utf-8 is also reasonable
  (setq powerline-default-separator 'bar)

  ;; A slimmer spaceline
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-major-mode-off)
  (spaceline-toggle-buffer-encoding-abbrev-off)

  ;; Only show time when window is close to the right and bottom edges
  (defun show-time ()
    (if (and
         (< (abs (- (nth 2 (window-edges)) (frame-width))) 7)
         (< (abs (- (nth 3 (window-edges)) (frame-height))) 7))
        (format-time-string "%H.%M")
      ""))

  (show-time)

  ;; Spaceline time
  (spaceline-define-segment time (show-time))
  ;; Keep clock somewhat refreshed
  (run-at-time "17 sec" 17 #'force-mode-line-update t)

  ;; Spaceline projectile
  (spaceline-define-segment projectile 'projectile-root)

  ;; Add time and projectile to spaceline. Is this the preferred way to add a segments?
  (spaceline-spacemacs-theme 'projectile-root 'time)

  ;; From https://github.com/syl20bnr/spacemacs/issues/5633#issuecomment-203771402
  ;; Close the vertical gap while in fullscreen
  ;; TODO Is this leading to helm failing to select items or render filtering?
  ;;      Seems that some combination of (un)full-screening and zooming
  ;;      returns things to a workable state.
  (setq frame-resize-pixelwise t)

  ;; Ligatures? Looks like this isn't sufficient
  ;; https://github.com/tonsky/FiraCode/wiki/Setting-up-Emacs seems to suggest more is required
  ;; (mac-auto-operator-composition-mode)

  ;; Don't conflict with Atom's symbols-view tag file defaults
  ;; (setq projectile-tags-file-name ".tags_emacs")

  ;; Ignore target so ctags is more reasonable with Scala projects
  (with-eval-after-load 'projectile
    (add-to-list 'projectile-globally-ignored-directories "target")
    (add-to-list 'projectile-globally-ignored-directories ".targets"))
  (setq projectile-tags-command "env TMPDIR=/tmp ctags -Re -f \"%s\" %s")

  ;; Reload tags without asking
  (setq tags-revert-without-query t)

  ;; Without this a few ensime related variables remain void. That leads to
  ;; issues with git-timemachine and the imenu based file summary, `SPC s j`,
  ;; due to at least ensime-imenu-index-function and imenu-auto-rescan being
  ;; uninitialized.
  ;; Related https://github.com/syl20bnr/spacemacs/issues/6578
  (require 'ensime)

  ;; Never keep current list of tags tables — https://emacs.stackexchange.com/q/14802
  (setq tags-add-tables nil)

  ;; TODO something currently broken with etags-select
  ;;      not showing all tags associated with a tag — working with the default `xref'?
  ;; Selection from multiple matching tags
  ;; (setq projectile-tags-backend 'etags-select)
  ;; TODO A nicer xref select via helm-xref until etags-select is fixed
  (require 'helm-xref)
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  (set-face-attribute 'helm-xref-file-name nil :foreground "systemBlueColor")

  ;; From http://ensime.org/editors/emacs/hacks/#tags
  ;; Fall back to ctags when ensime is unavailable
  (defun ensime-edit-definition-with-fallback ()
    "Variant of `ensime-edit-definition' with ctags if ENSIME is not available."
    (interactive)
    (unless (and (ensime-connection-or-nil)
                 (ensime-edit-definition-of-thing-at-point))
      ;; etags-select appears to need priming — perhaps this deserves an upstream fix
      (progn
        (message "falling back to tags")
        ;; Avoiding etags until above mentioned issue is fixed
        ;; (etags-select-find-tag-at-point)
        (evil-goto-definition)
        )))
  (add-hook 'scala-mode-hook
            (lambda ()
              (evil-define-key
                '(normal hybrid) ensime-mode-map
                (kbd "M-.") 'ensime-edit-definition-with-fallback)))
  (define-key evil-normal-state-map (kbd "M-.") nil)
  ;; Avoiding etags until above mentioned issue is fixed
  ;; (global-set-key (kbd "M-.") 'etags-select-find-tag-at-point)
  (global-set-key (kbd "M-.") 'xref-find-definitions)
  (global-set-key (kbd "M-,") 'pop-tag-mark)

  ;; A slimmer ensime modeline string
  ;; Scrivened from https://github.com/ensime/ensime-emacs/blob/master/ensime-mode.el#L485
  (defun ensime-modeline-string ()
    "The string to display in the modeline.
Only appears if we aren't connected. If connected,
include connection-name, and possibly some state information."
    (when ensime-mode
      (condition-case err
          (let ((conn (ensime-connection-or-nil)))
            (cond ((not conn)
                   (if (ensime-owning-server-process-for-source-file (buffer-file-name-with-indirect))
                       "♨"
                     "☉"))
                  ((ensime-connected-p conn)
                   (let ((config (ensime-config conn)))
                     (or (plist-get config :name)
                         "[Ensime ¯\_(ツ)_/¯ Proj]")))
                  (t "[Ensime ☠ Cnx]")))
        (error "[Ensime Error]"))))

  ;; Touch of scala mode customization
  (with-eval-after-load 'scala-mode
    (setq scala-indent:align-parameters nil)
    (setq scala-indent:default-run-on-strategy scala-indent:reluctant-strategy))

  ;; Turn off re-indent on return
  (global-set-key (kbd "RET") 'electric-newline-and-maybe-indent)

  ;; Touch of evil customization
  (setq evil-move-cursor-back nil) ;; Maintain position upon exiting insert mode

  ;; Ensime
  (setq ensime-startup-notification nil)
  (setq ensime-startup-snapshot-notification nil)

  ;; Additionally set normal-mode to follow common expectation
  (defun auto-save-command ()
    (progn
      ;; Avoid setting normal-mode on non-file buffers to preserve expected behavior
      ;; In particular but not limited to term and magit buffers
      ;; (if (not (string-prefix-p "*" (buffer-name))) (normal-mode))
      ;; TODO ↑ normal-mode causing issue with symbol-highlight exiting cleanly
      ;; TODO ↓ perhaps a less useful nowadays?
      ;; (if (not (string-prefix-p "*" (buffer-name))) (evil-escape))
      (save-some-buffers t)))

  ;; From Emacs Prelude — https://github.com/bbatsov/prelude
  (defmacro advise-commands (advice-name commands class &rest body)
    "Apply advice named ADVICE-NAME to multiple COMMANDS.

The body of the advice is in BODY."
    `(progn
       ,@(mapcar (lambda (command)
                   `(defadvice ,command (,class ,(intern (concat (symbol-name command) "-" advice-name)) activate)
                      ,@body))
                 commands)))

  ;; From Emacs Prelude — https://github.com/bbatsov/prelude
  ;; advise all window switching functions
  (advise-commands "auto-save"
                   (switch-to-buffer
                    other-window
                    windmove-up windmove-down windmove-left windmove-right
                    select-window)
                   before
                   (auto-save-command))

  ;; Save on buffer and window switch
  (add-hook 'focus-out-hook 'auto-save-command)

  ;; Sequester helm to a window instead of taking over full frame width
  ;; Required spacemacs workaround from https://github.com/syl20bnr/spacemacs/issues/9044
  ;; Appears to require being set after "auto-save" advise commands to be effective
  (setq-default helm-display-function 'helm-default-display-buffer)
  (setq helm-split-window-in-side-p t)

  ;; Experimental — access math keyboard layout
  (setq mac-option-modifier 'none)

  ;; Experimental — left meta for word traversal etc
  (setq ns-command-modifier 'meta)
  (setq ns-right-command-modifier 'super)

  ;; Set ensime search to the more useful ensime-helm-search
  (spacemacs/set-leader-keys-for-major-mode 'scala-mode
    "/"      'ensime-helm-search)

  ;; Switch TAB leader to the more commonly used buffer listing
  (spacemacs/set-leader-keys
    "TAB"    'helm-mini)

  ;; A more convenient projectile terminal
  (spacemacs/set-leader-keys
    "p#"     'projectile-multi-term-in-root)

  ;; A more convenient projectile switch open project
  (spacemacs/set-leader-keys
    "pq"     'projectile-switch-open-project)

  ;; A familiar projectile helm-mini
  (spacemacs/set-leader-keys
    "p TAB"   'helm-projectile)

  ;; A more direct workspaces transient state
  (spacemacs/set-leader-keys
    "W"      'spacemacs/workspaces-transient-state/body)

  ;; Leader key access to evil-window-set-height
  (spacemacs/set-leader-keys
    "w\\"    'evil-window-set-height)

  ;; Set current window to ⅔ frame height
  (defun set-window-⅔-height ()
      (interactive)
      (evil-window-set-height (floor (* (/ 2 3.0) (frame-height)))))

  ;; Leader key access to evil-window-set-height
  (spacemacs/set-leader-keys
    "w'"     'set-window-⅔-height)

  ;; Fish shell — some prompts may need this to work correctly
  (add-hook 'term-mode-hook 'toggle-truncate-lines)

  ;; A more familiar delete selection upon text entry
  (delete-selection-mode 1)

  ;; Adjust recenter defaults
  (setq recenter-positions '(middle 0.1 0.9))

  ;; List tags scoped to current buffer
  (defun list-buffer-tags ()
    (interactive)
    (list-tags (string-remove-prefix (projectile-project-root) buffer-file-name)))

  ;; A smoother list-buffer-tags workflow
  (push '("*Tags List*" :dedicated t :height 30) popwin:special-display-config)

  ;; Buffer tags as a leader key
  ;; Could additionally or alternatively fallback to
  ;; list-buffer-tags from helm-semantic-or-imenu `SPC s j`
  (spacemacs/set-leader-keys
    "bt" 'list-buffer-tags)

  ;; [WIP] Helm tags experiment
  ;; Files of interest
  ;;   - ~/.emacs.d/elpa/helm-core-20170727.1245/helm-source.el
  ;;   - ~/.emacs.d/elpa/helm-20170724.2137/helm-semantic.el (maybe)
  (defun helm-file-tags ()
    (interactive)
    (helm :sources (helm-build-sync-source "test"
                     :candidates (scala-imenu:create-imenu-index)
                     :fuzzy-match t
                     :action '(("open" . goto-char)
                               ("print info" . (lambda (candidate) (message "selected: %s" candidate)))))
          ;; :preselect (thing-at-point 'symbol t)
          :buffer "*helm file tags*"))

  ;; helm-file-tags as a leader key
  (spacemacs/set-leader-keys
    "bj" 'helm-file-tags)

  ;; List term buffers
  (defun helm-buffers-switch-to-term (prompt-prepend sources)
    (interactive)
    (helm :sources sources
          :prompt (funcall prompt-prepend "Switch to buffer: ")
          :buffer "*helm projectile*"
          :input "$*term "))

  ;; List all term buffers
  (defun helm-switch-to-term ()
    (interactive)
    (helm-buffers-switch-to-term
     'identity
     (helm-make-source "Term Buffers" 'helm-source-buffers)))

  ;; List projectile term buffers
  (defun helm-projectile-switch-to-term ()
    (interactive)
    (helm-buffers-switch-to-term
     'projectile-prepend-project-name
     (helm-build-sync-source "Term Buffers"
       :candidates (delete (buffer-name (current-buffer)) (projectile-project-buffer-names))
       :action 'switch-to-buffer)))

  ;; terms as a leader key
  ;; Why `o`? Available at both base and projectile menu levels.
  (spacemacs/set-leader-keys
    "o" 'helm-switch-to-term)

  ;; project-terms as a leader key
  (spacemacs/set-leader-keys
    "po" 'helm-projectile-switch-to-term)

  ;; ag project search hidden
  (defun helm-ag-project-hidden ()
    (interactive)
    (let ((helm-ag-base-command (concat helm-ag-base-command " --hidden")))
      (spacemacs/helm-project-smart-do-search)))

  ;; project search ag --hidden as a leader key
  (spacemacs/set-leader-keys
    "sah" 'helm-ag-project-hidden)
  (spacemacs/set-leader-keys
    "." 'helm-ag-project-hidden)


  ;; kill-buffer-and-widnwow as a leader keys
  (spacemacs/set-leader-keys
    "wx" 'kill-buffer-and-window)

  ;; Per Quasar query integration test definitions
  (add-to-list 'auto-mode-alist '("\\.test\\'" . json-mode))

  ;; [WIP] Display current commit in git timemachine transient display
  ;; Copied from spacemacs's init-git-timemachine for now. Any reuse possible?
  ;; Utilize :dynamic-hint to display current commit
  (use-package git-timemachine
    :defer t
    :commands spacemacs/time-machine-transient-state/body
    :init
    (spacemacs/set-leader-keys
      "gt" 'spacemacs/time-machine-transient-state/body)
    :config
    (progn
      (spacemacs|define-transient-state time-machine
        :title "Git Timemachine Transient State"
        :doc "
[_p_/_N_] previous [_n_] next [_c_] current [_g_] goto nth rev [_b_] blame [_Y_] copy hash [_q_] quit"
        :on-enter (let (golden-ratio-mode)
                    (unless (bound-and-true-p git-timemachine-mode)
                      (call-interactively 'git-timemachine)))
        :on-exit (when (bound-and-true-p git-timemachine-mode)
                   (git-timemachine-quit))
        :dynamic-hint (if git-timemachine-revision
                          (let* ((revision git-timemachine-revision)
                                 (date-relative (nth 3 revision))
                                 (date-full (nth 4 revision))
                                 (author (nth 6 revision))
                                 (sha (car revision))
                                 (sha-abbrev (git-timemachine-abbreviate sha))
                                 (subject (nth 5 revision)))
                            (format "\n\n%s — %s [%s (%s)] %s\n"
                                    author subject date-full date-relative sha-abbrev))
                        "")
        ;; :foreign-keys run
        :bindings
        ("c" git-timemachine-show-current-revision)
        ("g" git-timemachine-show-nth-revision)
        ("p" git-timemachine-show-previous-revision)
        ("n" git-timemachine-show-next-revision)
        ("N" git-timemachine-show-previous-revision)
        ("b" git-timemachine-blame :exit t)
        ("Y" git-timemachine-kill-revision)
        ("q" nil :exit t))))

  ;; A few git-messenger customizations
  (setq git-messenger:use-magit-popup t)
  (setq git-messenger:show-detail t)

  ;; [WIP] Constrain golden-ration to vertical
  (setq golden-ratio-adjust-factor 1.7)

  ;; [WIP] Ligatureish — ligatures instead as unicode glyph substitutions
  ;; https://github.com/be5invis/Iosevka/issues/56#issuecomment-291626486
  ;; From https://gist.github.com/mrkgnao/49c7480e1df42405a36b7ab09fe87f3d
  ;; Relies on a custom built font via https://github.com/drostron/Iosevka/tree/customization-lab
  ;; `gmake custom-config 'design=SCAL v-asterisk-low'`
  ;  `gmake custom`
  (defun setup-iosevka-ligatures ()
    (setq prettify-symbols-alist
          '(
            ;; Glyph composition offered to maintain preserve column position and proper replacement width
            ("->" . (#Xe149 (Bc . Br) ? ))
            (">-" . (#Xe15b (Bc . Br) ? ))
            ("=>" . (#Xe161 (Bc . Br) ? ))
            ("<-" . (#Xe179 (Br Bl -100 0) ? ))
            ("==" . (#Xe1cc (Bc . Br) ? ))
            ;; TODO unable to get column count to 3 for triple char substitutions
            ;;      using (Br Bl -100 0) ?a (Br Bl -100 0) ?b)
            (">>=" . (#Xe175 (Br Bl -100 0) ? ))
            ("===" . (#Xe176 (Br Bl -100 0) ? ))
            ("=/=" . (#Xe177 (Br Bl -100 0) ? ))
            (">=>" . (#Xe1a9 (Br Bl -100 0) ? ))
            (">==>" . #Xe1ac)
            (":=" . (#Xe1b7 (Bc . Br) ? ))
            )))

  (setq prettify-symbols-unprettify-at-point 'right-edge)

  (defun refresh-pretty ()
    (prettify-symbols-mode -1)
    (prettify-symbols-mode +1))

  ;; Hooks for modes in which to install the Iosevka or FiraCode ligatures/glyphs
  (mapc (lambda (hook)
          (add-hook hook (lambda () (setup-iosevka-ligatures) (refresh-pretty))))
        '(text-mode-hook
          prog-mode-hook))

  (global-prettify-symbols-mode t)

  ;; Prevent helm from using a new frame
  (setq helm-use-frame-when-more-than-two-windows nil)

  ;; Prevent ineffective arrow keys etc that print raw escape seq chars
  (setq multi-term-program "bash")

  ;; Adjust dired listing
  (setq dired-listing-switches "-alh")

  ;; Adjust default JS indentation
  (setq js-indent-level 2)

  ;; Alternate markdown preview command
  ;; https://jblevins.org/projects/markdown-mode/
  (setq markdown-command "marked")

  ;; Disable auto indent (undesirable result with some modes)
  ;; From https://github.com/syl20bnr/spacemacs/issues/4219#issuecomment-323558793
  (add-to-list 'spacemacs-indent-sensitive-modes 'nix-mode)

  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(col-highlight ((t (:background "#efeae9")))))
