;; Mind State Encoding Contract

(define-map mind-states
  { id: uint }
  {
    owner: principal,
    data-hash: (buff 32)
  }
)

(define-data-var next-id uint u0)

(define-public (encode-mind-state (data-hash (buff 32)))
  (let
    ((id (var-get next-id)))
    (var-set next-id (+ id u1))
    (ok (map-set mind-states
      { id: id }
      {
        owner: tx-sender,
        data-hash: data-hash
      }
    ))
  )
)

(define-read-only (get-mind-state (id uint))
  (map-get? mind-states { id: id })
)

