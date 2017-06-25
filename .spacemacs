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
     emacs-lisp
     git
     haskell
     helm
     html
     javascript
     lua
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     ;; org
     osx
     scala
     (shell :variables
            shell-default-position 'bottom
            shell-default-height 30)
     shell-scripts
     spell-checking
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
     etags-select
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
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
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
   dotspacemacs-emacs-leader-key "M-m"
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
  (global-set-key (kbd "s-F") 'isearch-backward)
  (global-set-key (kbd "s-G") 'isearch-repeat-backward)
  ;; Too close to evil-insert-digraph's C-k
  (global-unset-key (kbd "s-k"))
  ;; Set C-k to evil-insert-insert for evil hybrid mode
  (define-key evil-hybrid-state-map (kbd "C-k") 'evil-insert-digraph)
  ;; Add familiar command left and right for beginning and end of line
  (global-set-key (kbd "s-<left>") 'move-beginning-of-line)
  (global-set-key (kbd "s-<right>") 'move-end-of-line)
  ;; Add familiar end of line
  (define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
  ;; Additional evil-escape
  (global-set-key (kbd "C-g") 'evil-escape)
  ;; Hybrid (as in Vim mode) — execute next command in normal state
  (define-key evil-hybrid-state-map (kbd "C-o") 'evil-execute-in-normal-state)
  ;; A more familiar backward and forward jump (sort of)
  (define-key evil-normal-state-map (kbd "M-<up>") 'evil-jump-backward)
  (define-key evil-normal-state-map (kbd "M-<down>") 'evil-jump-forward)
  ;; A familiar backward and forward word for markdown mode
  (add-hook 'markdown-mode-hook
            (lambda ()
              (define-key markdown-mode-map (kbd "M-<left>") 'left-word)
              (define-key markdown-mode-map (kbd "M-<right>") 'right-word)))
  ;; A more familiar spelling correction
  (global-set-key (kbd "s-:") 'flyspell-correct-previous-word-generic)
  ;; Follow attempted usage
  (define-key evil-normal-state-map (kbd "C-d") 'delete-char)

  ;; A more familiar multi-select. Might move to evil-iedit-state/iedit-mode
  ;; Not sure why, but including expand-region under
  ;; dotspacemacs-additional-packages doesn't appear to load er/mark-word
  (require 'expand-region)
  (global-set-key (kbd "s-d")
                  (lambda ()
                    (interactive)
                    (cond ((region-active-p) (spacemacs/symbol-highlight))
                          (t (er/mark-word)))))

  ;; A more familiar and less jumpy mouse scroll
  (setq mouse-wheel-scroll-amount '(1))
  (setq mouse-wheel-progressive-speed nil)

  ;; A few digraph customizations
  (setq evil-digraphs-table-user
        '(
          ((?= ??) . ?\x225f)
          ))

  ;; More pleasing powerline separators, 'utf-8 is also reasonable
  (setq powerline-default-separator 'bar)

  ;; From https://github.com/syl20bnr/spacemacs/issues/5633#issuecomment-203771402
  ;; Close the vertical gap while in fullscreen
  (setq frame-resize-pixelwise t)

  ;; Ligatures? Looks like this isn't sufficient
  ;; https://github.com/tonsky/FiraCode/wiki/Setting-up-Emacs seems to suggest more is required
  ;; (mac-auto-operator-composition-mode)

  ;; Don't conflict with Atom's symbols-view tag file defaults
  (setq projectile-tags-file-name ".tags_emacs")

  ;; Ignore target so ctags is more reasonable with Scala projects
  (with-eval-after-load 'projectile
    (add-to-list 'projectile-globally-ignored-directories "target")
    (add-to-list 'projectile-globally-ignored-directories ".targets"))
  (setq projectile-tags-command "env TMPDIR=/tmp ctags -Re -f \"%s\" %s")

  ;; Never keep current list of tags tables — https://emacs.stackexchange.com/q/14802
  (setq tags-add-tables nil)

  ;; Selection from multiple matching tags
  (setq projectile-tags-backend 'etags-select)

  ;; From http://ensime.org/editors/emacs/hacks/#tags
  ;; Fall back to ctags when ensime is unavailable
  (defun ensime-edit-definition-with-fallback ()
    "Variant of `ensime-edit-definition' with ctags if ENSIME is not available."
    (interactive)
    (unless (and (ensime-connection-or-nil)
                 (ensime-edit-definition))
      ;; etags-select appears to need priming — perhaps this deserves an upstream fix
      (etags-select-find-tag-at-point)))
  (add-hook 'scala-mode-hook
            (lambda ()
              (evil-define-key
                '(normal hybrid) ensime-mode-map
                (kbd "M-.") 'ensime-edit-definition-with-fallback)))
  (global-set-key (kbd "M-.") 'projectile-find-tag)
  (global-set-key (kbd "M-,") 'pop-tag-mark)

  ;; TODO: Investigate — imenu-auto-rescan being void causing issues with git-timemachine
  ;; *Messages* "ensime--setup-imenu: Symbol’s value as variable is void: imenu-auto-rescan"
  (add-hook 'scala-mode-hook
            (lambda ()
              (unless (boundp 'imenu-auto-rescan) (setq imenu-auto-rescan t))))

  ;; Touch of scala mode customization
  (setq scala-indent:align-parameters nil)

  ;; Turn off re-indent on return
  (global-set-key (kbd "RET") 'electric-newline-and-maybe-indent)

  ;; Touch of evil customization
  (setq evil-move-cursor-back nil) ;; Maintain position upon exiting insert mode

  ;; Ensime
  (setq ensime-startup-notification nil)
  (setq ensime-startup-snapshot-notification nil)

  (defun auto-save-command () (save-some-buffers t))

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
                   (switch-to-buffer other-window windmove-up windmove-down windmove-left windmove-right)
                   before
                   (auto-save-command))

  ;; Save on buffer and window switch
  (add-hook 'focus-out-hook 'auto-save-command)

  ;; Experimental — access math keyboard layout
  (setq mac-option-modifier 'none)

  ;; Experimental — left meta for word traversal etc
  (setq ns-command-modifier 'meta)
  (setq ns-right-command-modifier 'super)

  ;; Set ensime search to the more useful ensime-helm-search
  (spacemacs/set-leader-keys-for-major-mode 'scala-mode
    "/"      'ensime-helm-search)

  ;; Fish shell — some prompts may need this to work correctly
  (add-hook 'term-mode-hook 'toggle-truncate-lines)

  ;; A more familiar delete selection upon text entry
  (delete-selection-mode 1)

  ;; Adjust recenter defaults
  (setq recenter-positions '(middle 0.08 0.9))

  ;; List tags scoped to current buffer
  (defun list-buffer-tags ()
    (interactive)
    (list-tags (string-remove-prefix (projectile-project-root) buffer-file-name)))

  ;; A smoother list-buffer-tags workflow
  (push '("*Tags List*" :dedicated t :height 30)
        popwin:special-display-config)

  ;; Buffer tags as a leader key
  ;; Could additionally or alternatively fallback to
  ;; list-buffer-tags from helm-semantic-or-imenu `SPC s j`
  (spacemacs/set-leader-keys
    "bt" 'list-buffer-tags)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
