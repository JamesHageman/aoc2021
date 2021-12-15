package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

type pos struct {
	// part 1
	x, y int

	// part 2
	aim   int
	depth int
}

func (p *pos) advance(s string) {
	parts := strings.Split(s, " ")

	n, err := strconv.Atoi(parts[1])
	if err != nil {
		panic(err)
	}

	switch parts[0] {
	case "forward":
		p.x += n
		p.depth += p.aim * n
	case "up":
		p.y += n
		p.aim -= n
	case "down":
		p.y -= n
		p.aim += n
	}
}

func absInt(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func run() error {
	p := pos{}

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		if err := scanner.Err(); err != nil {
			return err
		}
		line := scanner.Text()
		p.advance(line)
	}

	fmt.Println(absInt(p.x * p.y))
	fmt.Println(absInt(p.x * p.depth))

	return nil
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}
