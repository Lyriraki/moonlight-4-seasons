<script setup lang="ts">
// Vue 3 sample: script setup, props, emit, computed
import { computed, onMounted, ref, watch } from "vue";
import AppHeader from "./AppHeader.vue";

interface Props {
  title: string;
  max?: number;
}

const props = withDefaults(defineProps<Props>(), { max: 10 });
const emit = defineEmits<{
  (e: "done", count: number): void;
}>();

const count = ref(0);
const items = ref<string[]>(["One", "Two", "Three"]);
const doubled = computed(() => count.value * 2);

function increment(): void {
  if (count.value < props.max) count.value++;
  else emit("done", count.value);
}

watch(count, (now, before) => {
  console.log(`Changed from ${before} to ${now}`);
});

onMounted(async () => {
  const res = await fetch("https://example.com/api/items");
  items.value = await res.json();
});
</script>

<template>
  <AppHeader :title="title" level="2" />
  <main class="container" data-theme="dark">
    <h1>{{ title }}</h1>
    <p>Count: {{ count }} (doubled: {{ doubled }})</p>

    <button :disabled="count >= max" @click="increment">Add</button>

    <p v-if="count === 0">No clicks yet.</p>
    <p v-else-if="count < max">Keep clicking!</p>
    <p v-else>Maximum reached.</p>

    <ul>
      <li v-for="(item, i) in items" :key="item" :class="{ active: i === 0 }">
        {{ i + 1 }}. {{ item }}
      </li>
    </ul>
    <a href="/privacy/">Continue</a>
  </main>
</template>

<style scoped>
.container {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

li.active {
  font-weight: bold;
  color: var(--primary, #7c5cff);
}
</style>
