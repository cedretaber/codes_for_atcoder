(ns d.core)

(require '[clojure.string :as str :only (split join)])

(defn- do-solve
  [p k kk s]
  (if (empty? s)
    (if (== p 0)
      (concat kk (reverse k))
      (recur (- p 1) (cons ")" k) kk s))
    (let [[c & cs] s]
      (case c
        "(" (if (== p 0)
          (recur (+ p 1) '("(") (concat kk (reverse k)) cs)
          (recur (+ p 1) (cons "(" k) kk cs))
        ")" (if (== p 0)
          (recur p (cons ")" k) (cons "(" kk) cs)
          (recur (- p 1) (cons ")" k) kk cs))))))

(defn solve [s] (do-solve 0 () () s))

(defn -main []
  (read-line)
  (println
    (str/join ""
      (solve (str/split (read-line) #"")))))