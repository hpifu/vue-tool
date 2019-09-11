#!/usr/bin/env python3

import hashlib
import unittest
import mmh3


def md5(text):
    return hashlib.md5(text.encode()).hexdigest()


def murmur3_32(text):
    val = mmh3.hash(text)
    return val if val >= 0 else val + 2**32


def murmur3_64(text):
    val, _ = mmh3.hash64(text)
    return val if val >= 0 else val + 2**64


def murmur3_128(text):
    v1, v2 = mmh3.hash64(text)
    v1 = v1 if v1 >= 0 else v1 + 2**64
    v2 = v2 if v2 >= 0 else v2 + 2**64
    return v1, v2


class TestCase(unittest.TestCase):
    def testmd5(self):
        self.assertEqual(
            md5("hello world"),
            "5eb63bbbe01eeed093cb22bb8f5acdc3"
        )
        self.assertEqual(
            md5("你好世界\n"),
            "5117e9aab782e62949849b9977e3d8b0"
        )

    def testmurmur3_32(self):
        self.assertEqual(
            murmur3_32("hello world"),
            1586663183
        )
        self.assertEqual(
            murmur3_32("你好世界\n"),
            4259607414
        )

    def testmurmur3_64(self):
        self.assertEqual(
            murmur3_64("hello world"),
            5998619086395760910
        )
        self.assertEqual(
            murmur3_64("你好世界"),
            12314529345063139381
        )

    def testmurmur3_128(self):
        self.assertEqual(
            murmur3_128("hello world"),
            (5998619086395760910, 12364428806279881649)
        )
        self.assertEqual(
            murmur3_128("你好世界"),
            (12314529345063139381, 9772107468162238917)
        )


def main():
    unittest.main()


if __name__ == "__main__":
    main()
