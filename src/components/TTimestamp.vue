<template>
  <v-layout justify-center row fill-height text-center>
    <v-flex xs6 text-center>
      <v-layout wrap text-center>
        <v-flex xs12>
          <v-text-field v-model="ts" outlined label="时间戳"></v-text-field>
        </v-flex>
        <v-flex xs12>
          <v-text-field v-model="bjtime" outlined label="北京时间"></v-text-field>
        </v-flex>
        <v-flex xs12>
          <v-text-field v-model="utctime" outlined label="UTC时间"></v-text-field>
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
</template>


<script>
export default {
  methods: {
    async copyToClipboard() {
      try {
        await navigator.clipboard.writeText(this.num2);
      } catch (err) {
        this.errors = [err];
      }
    },
    rfc3339(d, offset) {
      function pad(n) {
        return n < 10 ? "0" + n : n;
      }
      function timezoneOffset(offset) {
        var sign;
        if (offset === 0) {
          return "Z";
        }
        sign = offset > 0 ? "-" : "+";
        offset = Math.abs(offset);
        return sign + pad(Math.floor(offset / 60)) + ":" + pad(offset % 60);
      }
      return (
        d.getFullYear() +
        "-" +
        pad(d.getMonth() + 1) +
        "-" +
        pad(d.getDate()) +
        "T" +
        pad(d.getHours()) +
        ":" +
        pad(d.getMinutes()) +
        ":" +
        pad(d.getSeconds()) +
        timezoneOffset(offset)
      );
    }
  },
  computed: {
    bjtime: {
      get() {
        var d = new Date(this.ts * 1000);
        return this.rfc3339(d, d.getTimezoneOffset());
      },
      set(t) {
        this.ts = Math.round(new Date(t).getTime() / 1000);
      }
    },
    utctime: {
      get() {
        var d = new Date(this.ts * 1000);
        return d.toISOString();
      },
      set(t) {
        this.ts = Math.round(new Date(t).getTime() / 1000);
      }
    }
  },
  data: () => {
    return {
      ts: Math.round(new Date().getTime() / 1000)
    };
  }
};
</script>
