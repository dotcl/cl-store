;;; -*- Mode: LISP; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;; See the file LICENCE for licence information.

(in-package :cl-store)

;; special floats. Dividing by a float zero answers an infinity on dotcl
;; (IEEE 754, as .NET does), which EXPT overflowing does not.
(defun create-float-values (value &rest codes)
  "Returns a alist of special float to float code mappings."
  (let* ((zero (float 0 value))
         (inf (/ (abs value) zero)))
    (mapcar 'cons
            (list inf
                  (/ value zero)
                  (- inf inf))
            codes)))

;; Custom structure storing

(defstore-cl-store (obj structure-object stream)
  (output-type-code +structure-object-code+ stream)
  (store-type-object obj stream))

(defrestore-cl-store (structure-object stream)
  (restore-type-object stream))
