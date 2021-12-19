// I gave up on this one and rewrote day3 in ruby 😅
package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func main() {
	s := bufio.NewScanner(os.Stdin)

	var lines []string

	for s.Scan() {
		if err := s.Err(); err != nil {
			log.Fatal(err)
		}

		lines = append(lines, s.Text())
	}

	ones := make([]int, len(lines[0]))
	zeros := make([]int, len(lines[0]))

	for _, line := range lines {
		for i, c := range line {
			switch c {
			case '0':
				zeros[i]++
			case '1':
				ones[i]++
			}
		}
	}

	var gamma uint64 = 0
	var mask uint64 = 0

	for i := range ones {
		mask = mask | (1 << i)
		bit := len(ones) - i - 1
		if ones[i] > zeros[i] {
			gamma = gamma | (1 << bit)
		}
	}

	var epsilon uint64 = (gamma ^ mask)

	fmt.Printf("gamma  =%012b\n", gamma)
	fmt.Printf("epsilon=%012b\n", epsilon)

	fmt.Println("part 1:", gamma*epsilon)

	oxygen := map[string]struct{}{}
	co2 := map[string]struct{}{}
	for _, l := range lines {
		oxygen[l] = struct{}{}
		co2[l] = struct{}{}
	}

	for i := range ones {
		expected := byte('0')
		if ones[i] >= zeros[i] {
			expected = '1'
		}

		for line := range oxygen {
			if line[i] != expected {
				delete(oxygen, line)
			}
		}

		if len(oxygen) <= 1 {
			break
		}
	}

	fmt.Printf("oxygen=%s", oxygen)
}

func firstKey(m map[string]struct{}) string {
	for k := range m {
		return k
	}
	panic("empty map")
}
