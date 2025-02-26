;; Host Compatibility Contract

(define-map hosts
  { id: uint }
  {
    compatibility-score: uint
  }
)

(define-data-var next-id uint u0)

(define-public (register-host (compatibility-score uint))
  (let
    ((id (var-get next-id)))
    (var-set next-id (+ id u1))
    (ok (map-set hosts
      { id: id }
      {
        compatibility-score: compatibility-score
      }
    ))
  )
)

(define-read-only (check-compatibility (host-id uint) (required-score uint))
  (match (map-get? hosts { id: host-id })
    host (>= (get compatibility-score host) required-score)
    false
  )
)

