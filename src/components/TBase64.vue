<template>
  <v-layout justify-center row fill-height text-center mt-5>
    <v-flex xs6 text-center>
      <v-layout wrap text-center>
        <v-flex xs12>
          <v-textarea v-model="originText" outlined label="原始文本" auto-grow value></v-textarea>
        </v-flex>
        <v-flex xs12>
          <v-textarea v-model="encodeText" outlined label="编码文本" auto-grow value></v-textarea>
        </v-flex>

        <v-flex xs12>
          <v-layout justify-center row fill-height text-center>
            <v-flex xs3>
              <v-switch
                v-model="isurlsafe"
                :label="isurlsafe ? 'urlsafe_base64': 'std_base64'"
                color="primary"
              ></v-switch>
            </v-flex>
            <v-flex xs2>
              <v-btn
                color="primary"
                class="ml-5 mt-3"
                @click="isurlsafe ? urlsafeB64encode() : b64encode()"
                rounded
                outlined
              >编码</v-btn>
            </v-flex>
            <v-flex xs2>
              <v-btn
                color="primary"
                class="mr-5 mt-3"
                @click="isurlsafe ? urlsafeB64decode() : b64decode()"
                rounded
                outlined
              >解码</v-btn>
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
    b64encode() {
      this.encodeText = CryptoJS.enc.Base64.stringify(
        CryptoJS.enc.Utf8.parse(this.originText)
      );
    },
    b64decode() {
      this.originText = CryptoJS.enc.Base64.parse(this.encodeText).toString(
        CryptoJS.enc.Utf8
      );
    },
    urlsafeB64encode() {
      var text = CryptoJS.enc.Base64.stringify(
        CryptoJS.enc.Utf8.parse(this.originText)
      );
      this.encodeText = text
        .replace(/\+/g, "-")
        .replace(/\//g, "_")
        .replace(/=/g, "");
    },
    urlsafeB64decode() {
      var text = this.encodeText.replace(/-/g, "+").replace(/_/g, "/");
      this.originText = CryptoJS.enc.Base64.parse(text).toString(
        CryptoJS.enc.Utf8
      );
    }
  },
  data: () => {
    return {
      isurlsafe: false,
      originText: "",
      encodeText: ""
    };
  }
};
</script>
