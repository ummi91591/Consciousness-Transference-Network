;; Ethical Oversight Contract

(define-map transfer-approvals
  { id: uint }
  {
    approved: bool,
    reason: (string-ascii 64)
  }
)

(define-data-var next-id uint u0)

(define-public (request-approval (mind-state-id uint) (to-host uint))
  (let
    ((id (var-get next-id)))
    (var-set next-id (+ id u1))
    (ok (map-set transfer-approvals
      { id: id }
      {
        approved: false,
        reason: "Pending review"
      }
    ))
  )
)

(define-public (approve-transfer (id uint))
  (ok (map-set transfer-approvals
    { id: id }
    {
      approved: true,
      reason: "Approved"
    }
  ))
)

(define-public (reject-transfer (id uint) (reason (string-ascii 64)))
  (ok (map-set transfer-approvals
    { id: id }
    {
      approved: false,
      reason: reason
    }
  ))
)

(define-read-only (get-approval-status (id uint))
  (map-get? transfer-approvals { id: id })
)

