<template>
  <span class="cyan--text hlogo-text">{{value}}</span>
</template>

<style>
span.hlogo-text {
  font-family: "Monoton";
  font-size: 1.2rem;
}
</style>

<script>
export default {
  props: {
    value: {
      default: "text"
    }
  }
};
</script>