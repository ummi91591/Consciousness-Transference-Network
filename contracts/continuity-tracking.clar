;; Continuity Tracking Contract

(define-map transfers
  { id: uint }
  {
    mind-state-id: uint,
    from-host: uint,
    to-host: uint
  }
)

(define-data-var next-id uint u0)

(define-public (record-transfer (mind-state-id uint) (from-host uint) (to-host uint))
  (let
    ((id (var-get next-id)))
    (var-set next-id (+ id u1))
    (ok (map-set transfers
      { id: id }
      {
        mind-state-id: mind-state-id,
        from-host: from-host,
        to-host: to-host
      }
    ))
  )
)

(define-read-only (get-transfer (id uint))
  (map-get? transfers { id: id })
)

