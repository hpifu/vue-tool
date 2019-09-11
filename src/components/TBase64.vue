<template>
  <v-layout justify-center row fill-height text-center>
    <v-flex xs6 text-center>
      <v-layout wrap text-center>
        <v-flex xs12>
          <v-textarea
            v-model="text"
            label="文本"
            outlined
            auto-grow
            :error-messages="errors"
            append-icon="mdi-content-copy"
            @click:append="copyToClipboard"
          ></v-textarea>
        </v-flex>

        <v-flex xs12>
          <v-layout justify-center row text-center>
            <v-flex xs4>
              <v-btn
                color="primary"
                @click="stdBase64Encode"
                class="my-3"
                rounded
                depressed
              >std base64 编码</v-btn>
            </v-flex>
            <v-flex xs4>
              <v-btn
                color="primary"
                @click="stdBase64Decode"
                class="my-3"
                rounded
                depressed
              >std base64 解码</v-btn>
            </v-flex>
          </v-layout>
          <v-layout justify-center row text-center>
            <v-flex xs4>
              <v-btn
                color="primary"
                @click="urlBase64Encode"
                class="my-3"
                rounded
                depressed
              >url base64 编码</v-btn>
            </v-flex>
            <v-flex xs4>
              <v-btn
                color="primary"
                @click="urlBase64Decode"
                class="my-3"
                rounded
                depressed
              >url base64 解码</v-btn>
            </v-flex>
          </v-layout>
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
</template>


<script>
const CryptoJS = require("crypto-js");

export default {
  methods: {
    async copyToClipboard() {
      try {
        await navigator.clipboard.writeText(this.text);
      } catch (err) {
        this.errors = [err];
      }
    },
    stdBase64Encode() {
      this.text = CryptoJS.enc.Base64.stringify(
        CryptoJS.enc.Utf8.parse(this.text)
      );
      this.errors = [];
    },
    stdBase64Decode() {
      try {
        this.text = CryptoJS.enc.Base64.parse(this.text).toString(
          CryptoJS.enc.Utf8
        );
        this.errors = [];
      } catch (e) {
        this.errors = [e];
      }
    },
    urlBase64Encode() {
      var text = CryptoJS.enc.Base64.stringify(
        CryptoJS.enc.Utf8.parse(this.text)
      );
      this.text = text
        .replace(/\+/g, "-")
        .replace(/\//g, "_")
        .replace(/=/g, "");
      this.errors = [];
    },
    urlBase64Decode() {
      var text = this.text.replace(/-/g, "+").replace(/_/g, "/");
      try {
        this.text = CryptoJS.enc.Base64.parse(text).toString(CryptoJS.enc.Utf8);
        this.errors = [];
      } catch (e) {
        this.errors = [e];
      }
    }
  },
  data: () => {
    return {
      text: "你好，世界",
      errors: []
    };
  }
};
</script>
