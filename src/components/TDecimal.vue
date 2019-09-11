<template>
  <v-layout justify-center row fill-height text-center>
    <v-flex xs10 md8 lg8 xl6 text-center>
      <v-layout wrap text-center>
        <v-flex xs10 pr-5>
          <v-text-field v-model="num1" outlined label="原数" auto-grow :error-messages="errors"></v-text-field>
        </v-flex>
        <v-flex xs2>
          <v-select
            v-model="d1"
            :items="[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]"
            label="进制"
            outlined
          ></v-select>
        </v-flex>
        <v-flex xs10 pr-5>
          <v-text-field
            v-model="num2"
            outlined
            label="新数"
            auto-grow
            append-icon="mdi-content-copy"
            @click:append="copyToClipboard"
            :error-messages="errors"
          ></v-text-field>
        </v-flex>
        <v-flex xs2>
          <v-select
            v-model="d2"
            :items="[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]"
            label="进制"
            outlined
          ></v-select>
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
</template>


<script>
var convertBase = require("bigint-base-converter");

export default {
  methods: {
    async copyToClipboard() {
      try {
        await navigator.clipboard.writeText(this.num2);
      } catch (err) {
        this.errors = [err];
      }
    }
  },
  computed: {
    num2() {
      if (!this.num1) {
        return "";
      }
      const chars = "0123456789abcdefghijklmnopqrstuvwxyz";
      var ctoi = {};
      for (var i in chars) {
        ctoi[chars.charAt(i)] = i;
      }
      var abc = this.num1.split("").map(c => ctoi[c]);
      return convertBase(abc, this.d1, this.d2)
        .map(i => chars.charAt(i))
        .reduce((a, b) => a + b);
    }
  },
  data: () => {
    return {
      num1: "",
      d1: 10,
      d2: 16,
      errors: []
    };
  }
};
</script>
