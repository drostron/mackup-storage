;; col-highlight and vline are no longer available via MELPA
(defconst col-highlight-packages
  '(
    (col-highlight :location local)
    (vline :location local)))

(defun col-highlight/init-col-highlight ()
  (use-package col-highlight
    :requires vline))

(defun col-highlight/init-vline ()
  (use-package vline))
