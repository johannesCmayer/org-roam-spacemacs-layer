(defconst org-roam-packages
  '(
    (org-roam :location
              (recipe :fetcher github :repo "org-roam/org-roam"))
    (org-roam-bibtex :location
                     (recipe :fetcher github :repo "org-roam/org-roam-bibtex"))
    (org-roam-timestamps :location
                         (recipe :fetcher github :repo "tefkah/org-roam-timestamps"))
    org-roam-ui
    (org-roam-ui :location elpa)
   )
)

;; This defun is taken from a forum answer that I can't be bothered to look up again.
(defun org-roam/init-org-roam ()
  (use-package org-roam
    :defer t
    :hook (after-init . org-roam-mode)
    :init
    (setq org-roam-v2-ack t)
    :custom
    (org-roam-directory "~/org") ;; please change it to your path
    :config
    (progn
      (spacemacs/declare-prefix "aor" "org-roam")
      (spacemacs/declare-prefix "aord" "org-roam-dailies")
      (spacemacs/declare-prefix "aort" "org-roam-tags")
      (spacemacs/set-leader-keys
        "aordy" 'org-roam-dailies-goto-yesterday
        "aordt" 'org-roam-dailies-goto-today
        "aordT" 'org-roam-dailies-goto-tomorrow
        "aordd" 'org-roam-dailies-goto-date
        "aor/" 'org-roam-node-find
        "aorc" 'org-roam-capture
        ;; "aorg" 'org-roam-graph
        "aori" 'org-roam-node-insert
        "aorl" 'org-roam-buffer-toggle
        "aorta" 'org-roam-tag-add
        "aortd" 'org-roam-tag-delete
        "aora" 'org-roam-alias-add)

      (spacemacs/declare-prefix-for-mode 'org-mode "mr" "org-roam")
      (spacemacs/declare-prefix-for-mode 'org-mode "mrd" "org-roam-dailies")
      (spacemacs/declare-prefix-for-mode 'org-mode "mrt" "org-roam-tags")
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "rb" 'org-roam-switch-to-buffer
        "rdy" 'org-roam-dailies-goto-yesterday
        "rdt" 'org-roam-dailies-goto-today
        "rdT" 'org-roam-dailies-goto-tomorrow
        "rdd" 'org-roam-dailies-goto-date
        "r/" 'org-roam-node-find
        "rc" 'org-roam-capture
        ;; "rg" 'org-roam-graph
        "ri" 'org-roam-node-insert
        "rl" 'org-roam-buffer-toggle
        "rta" 'org-roam-tag-add
        "rtd" 'org-roam-tag-delete
        "ra" 'org-roam-alias-add))
    (setq org-roam-mode-sections
          (list #'org-roam-backlinks-insert-section
                #'org-roam-reflinks-insert-section
                ))
    (setq org-roam-file-extensions '("org"))
    (org-roam-setup)

    ;; templates
    (setq org-roam-capture-templates
          '(
            ("d" "default" plain
             "%?"
             :if-new (file+head "${slug}.org"
                                "#+title: ${title}\n")
             :immediate-finish t
             :unnarrowed t)
            ("r" "ref" plain
             "%?"
             :if-new (file+head "./ref_notes/${slug}.org"
                                "#+title: ${title}\n")
             :unnarrowed t)))
    (setq org-roam-dailies-directory "daily/")
    (setq org-roam-dailies-capture-templates
          '(("d" "default" entry
             "* %?"
             :if-new (file+head "%<%Y-%m-%d>.org"
                                "#+title: %<%Y-%m-%d>\n"))))
))

(defun org-roam/init-org-roam-bibtex ()
  (use-package org-roam-bibtex
    :after org-roam
    :hook (org-roam-mode . org-roam-bibtex-mode)
    :bind (:map org-mode-map
                (("C-c n a" . orb-note-actions)))))

(defun org-roam/init-org-roam-timestamps ()
  (use-package org-roam-timestamps
    :after org-roam
    :hook (org-roam-mode . org-roam-timestamp-mode)
  )
)

(defun org-roam/init-org-roam-ui ()
  (use-package org-roam-ui
    :after org-roam-timestamps
    :config
    (progn
      (spacemacs/declare-prefix "aor" "org-roam")
      (spacemacs/set-leader-keys
        "aoro" 'org-roam-ui-open
      )
    )
  )
)
