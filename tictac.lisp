;;;; tictac.lisp

(in-package #:tictac)

(defvar *screen-width* 800)
(defvar *screen-height* 600)

(defvar *x-img* nil)
(defvar *o-img* nil)
(defvar *grid-img* nil)

(defun load-image (renderer filename)
  (let ((image-surface (sdl2-image:load-image filename)))
    (sdl2:create-texture-from-surface renderer image-surface)))

(defun load-images (renderer)
  (setf *x-img* (load-image renderer "x.png"))
  (setf *o-img* (load-image renderer "o.png"))
  (setf *grid-img* (load-image renderer "grid.png")))

(defun init-game (renderer)
  ;; (sdl2-ffi:+sdl-hint-render-scale-quality+ 1)
  (load-images renderer))

(defun handle-key (keysym)
  (case (sdl2:scancode keysym)
    (:scancode-escape (sdl2:push-event :quit))))

(defun draw-game (renderer)
  (sdl2:render-clear renderer)
  (sdl2:set-render-draw-color renderer #xFF #xFF #xFF #xFF)
  (sdl2:render-copy renderer *grid-img*
                    :dest-rect (sdl2:make-rect 0 0
                                               *screen-width*
                                               *screen-height*))
  (sdl2:render-present renderer))

(defun main ()
  (sdl2:with-init (:video)
    (sdl2-image:init '(:png))
    (sdl2:with-window (window :title "tictac"
                              :w *screen-width*
                              :h *screen-height*
                              :flags '(:shown))
      (sdl2:with-renderer (renderer window
                                    :index -1
                                    :flags '(:accelerated))
        (init-game renderer)
        (sdl2:with-event-loop (:method :poll)
          (:quit () t)
          (:keydown (:keysym keysym) (handle-key keysym))
          (:idle () (draw-game renderer)))))))
