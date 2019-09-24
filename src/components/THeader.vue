<template>
  <v-app-bar app clipped-left elevate-on-scroll class="pb-3" color="#fafafa">
    <Logo value="HPiFu" />&nbsp;&nbsp;
    <SubLogo value="tool" />
    <v-spacer></v-spacer>
  </v-app-bar>
</template>

<script>
import Logo from "./Logo";
import SubLogo from "./SubLogo";

export default {
  components: {
    Logo,
    SubLogo
  }
};
</script>