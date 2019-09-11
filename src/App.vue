<template>
  <v-app>
    <THeader />
    <TSlider />

    <v-content>
      <transition name="slide-x-transition" mode="out-in">
        <v-container mt-10>
          <router-view></router-view>
        </v-container>
      </transition>
    </v-content>
  </v-app>
</template>

<script>
import THeader from "./components/THeader";
import TSlider from "./components/TSlider";

export default {
  name: "App",
  components: {
    THeader,
    TSlider
  },
  data: () => ({
    //
  })
};
</script>
