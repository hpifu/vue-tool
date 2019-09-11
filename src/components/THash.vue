<template>
  <v-layout justify-center row fill-height text-center mt-5>
    <v-flex xs6 text-center>
      <v-layout wrap text-center>
        <v-flex xs12>
          <v-textarea v-model="originText" outlined label="原始文本" auto-grow value></v-textarea>
        </v-flex>
        <v-flex xs12>
          <v-text-field
            v-model="encodeText"
            outlined
            label="编码文本"
            auto-grow
            value
            append-icon="mdi-content-copy"
            @click:append="copyToClipboard"
            :error-messages="errors"
          ></v-text-field>
        </v-flex>

        <v-flex xs12>
          <v-layout justify-center row fill-height text-center>
            <v-flex xs3>
              <v-btn color="primary" @click="md5" rounded outlined>md5</v-btn>
            </v-flex>
            <v-flex xs3>
              <v-btn color="primary" @click="murmur3_32" rounded outlined>murmur3_32</v-btn>
            </v-flex>
            <v-flex xs3>
              <v-btn color="primary" @click="murmur3_64" rounded outlined>murmur3_64</v-btn>
            </v-flex>
            <v-flex xs3>
              <v-btn color="primary" @click="murmur3_128" rounded outlined>murmur3_128</v-btn>
            </v-flex>
          </v-layout>
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
</template>


<script>
const CryptoJS = require("crypto-js");
const murmurHash3 = require("murmur-hash").v3;

export default {
  methods: {
    async copyToClipboard() {
      try {
        await navigator.clipboard.writeText(this.encodeText);
      } catch (err) {
        this.errors = [err];
      }
    },
    md5() {
      this.encodeText = CryptoJS.MD5(this.originText).toString();
    },
    murmur3_32() {
      this.encodeText = murmurHash3.x86.hash32(
        unescape(encodeURIComponent(this.originText))
      );
    },
    murmur3_64() {
      var hex = murmurHash3.x64.hash128(
        unescape(encodeURIComponent(this.originText))
      );
      var bi = BigInt("0x" + hex);
      this.encodeText = (bi / BigInt(2 ** 64)).toString();
    },
    murmur3_128() {
      var hex = murmurHash3.x64.hash128(
        unescape(encodeURIComponent(this.originText))
      );
      var bi = BigInt("0x" + hex);
      var v1 = bi / BigInt(2 ** 64);
      var v2 = bi % BigInt(2 ** 64);
      this.encodeText = "(" + v1.toString() + ", " + v2.toString() + ")";
    }
  },
  data: () => {
    return {
      isurlsafe: false,
      originText: "",
      encodeText: "",
      errors: []
    };
  }
};
</script>
