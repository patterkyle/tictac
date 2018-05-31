;;;; tictac.asd

(asdf:defsystem #:tictac
  :description "Describe tictac here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:vecto #:sdl2 #:sdl2-image)
  :components ((:file "package")
               (:file "tictac")))
