<template>
  <v-navigation-drawer floating color="rgb(0, 0, 0, 0)" app cliped>
    <v-flex xs12>
      <v-card height="100" color="rgb(0, 0, 0, 0)" flat></v-card>
    </v-flex>
    <v-list dense rounded>
      <v-list-item-group v-model="idx" color="primary">
        <template v-for="(item, i) in items">
          <template v-if="item.divider">
            <v-divider :key="i"></v-divider>
          </template>
          <template v-else>
            <v-list-item :to="item.to" :key="i">
              <v-list-item-icon>
                <v-icon filled>{{ item.icon }}</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>
                  <span>{{ item.title }}</span>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </template>
        </template>
      </v-list-item-group>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  data() {
    return {
      idx: 1,
      items: [
        { title: "base64 编解码", icon: "mdi-emoticon", to: "/base64" },
        { title: "hash 签名", icon: "mdi-emoticon", to: "/hash" },
        { title: "进制转换", icon: "mdi-emoticon", to: "/decimal" },
        { title: "时间戳", icon: "mdi-emoticon", to: "/timestamp" }
        // { divider: true },
      ]
    };
  }
};
</script>
