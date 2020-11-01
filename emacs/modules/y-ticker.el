;; (require 'request)
;; (require 'json)

;; ;; +---------------+
;; ;; | Customization |
;; ;; +---------------+

;; (defgroup crypto-ticker nil
;;   "\ncrypto-ticker extension"
;;   :group 'comms
;;   :prefix "crypto-ticker-")

;; (defcustom crypto-ticker-cryptocurrencies '("BTC" "ETH")
;;   "List of cryptocurrencies to fetch the prices of"
;;   :type 'list
;;   :group 'crypto-ticker)

;; (defcustom crypto-ticker-api-poll-interval 10
;;   "Default interval to poll cryptocurrency prices"
;;   :type 'number
;;   :group 'crypto-ticker)



;; (defvar 

;; (defun crypto-ticker-format-mode-line

;; (defvar btc-ticker-mode-line " ₿=0.00 Ξ=0.00" "Displayed on mode-line")

;; (define-minor-mode crypto-ticker-mode
;;   "XXX"
;;   :init-value nil
;;   :global t
;;   :lighter crypto-ticker-mode-line
;;   (if btc-ticker-mode
;;       (progn
;;         (btc-ticker-start)
;;         )
;;     (btc-ticker-stop)
;;     ))

(provide 'y-ticker)
