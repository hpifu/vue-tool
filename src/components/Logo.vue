<template>
  <span class="teal--text hlogo-title">{{value}}</span>
</template>

<style>
span.hlogo-title {
  font-family: "Monoton";
  font-size: 1.5rem;
}
</style>

<script>
export default {
  props: {
    value: {
      default: "title"
    }
  }
};
</script>
