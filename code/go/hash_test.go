package main

import (
	"fmt"
	"testing"

	"github.com/spaolacci/murmur3"
)

func TestMurmur3(t *testing.T) {
	val1 := murmur3.Sum32([]byte("你好世界"))
	fmt.Println(val1)

	val2 := murmur3.Sum64([]byte("你好世界"))
	fmt.Println(val2)

	v1, v2 := murmur3.Sum128([]byte("你好世界"))
	fmt.Println(v1, v2)
}
