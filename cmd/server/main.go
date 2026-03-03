package main

import (
	"net/http"

	"github.com/YeiyoNathnael/ADUEvents/views"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func main() {

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Handle("/assets/*", http.StripPrefix("/assets/", http.FileServer(http.Dir("assets"))))

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		if err := views.Index().Render(r.Context(), w); err != nil {
			http.Error(w, "failed to render page", http.StatusInternalServerError)
		}
	})

	http.ListenAndServe(":3000", r)
}
