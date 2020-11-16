;;; lsp-kotlin.el --- Kotlin support for lsp-mode -*- lexical-binding: t -*-
(require 'lsp-mode)

(defcustom lsp-kotlin-executable-path "kotlin"
  "Path to Kotlin executable."
  :group 'lsp-kotlin
  :type 'string)

(defcustom lsp-kotlin-server-args '()
  "Extra arguments for the Kotlin language server."
  :group 'lsp-kotlin
  :type '(repeat string))

(defun lsp-kotlin--server-command ()
  "Generate the language server startup command."
  `(,lsp-kotlin-executable-path "--lib" "kotlin-langserver" ,@lsp-kotlin-server-args))

(defvar lsp-kotlin--config-options `())

(lsp-register-client
 (make-lsp-client :new-connection
                  (lsp-stdio-connection 'lsp-kotlin--server-command)
                  :major-modes '(kotlin-mode)
                  :server-id 'kotlin
                  :initialized-fn (lambda (workspace)
                                    (with-lsp-workspace workspace
                                      (lsp--set-configuration
                                       `(:kotlin ,lsp-kotlin--config-options))))))

(provide 'lsp-kotlin)
;;; lsp-kotlin.el ends here