// Go sample: struct, interface, goroutine, error handling
package main

import (
	"errors"
	"fmt"
	"strings"
	"sync"
)

const MaxItems = 100

type Shape interface {
	Area() float64
}

type Rect struct {
	Width, Height float64
	Name          string `json:"name"`
}

func (r Rect) Area() float64 {
	return r.Width * r.Height
}

func NewRect(w, h float64) (*Rect, error) {
	if w <= 0 || h <= 0 {
		return nil, errors.New("size must be positive")
	}
	return &Rect{Width: w, Height: h, Name: "box"}, nil
}

func worker(id int, jobs <-chan int, wg *sync.WaitGroup) {
	defer wg.Done()
	for j := range jobs {
		fmt.Printf("worker %d processing %d\n", id, j)
	}
}

func main() {
	rect, err := NewRect(3, 4.5)
	if err != nil {
		fmt.Println("error:", err)
		return
	}

	var shapes []Shape
	shapes = append(shapes, rect)

	jobs := make(chan int, MaxItems)
	var wg sync.WaitGroup
	for i := 1; i <= 3; i++ {
		wg.Add(1)
		go worker(i, jobs, &wg)
	}
	for n := 0; n < 5; n++ {
		jobs <- n
	}
	close(jobs)
	wg.Wait()

	fmt.Println(strings.ToUpper("done"), shapes[0].Area())
}
