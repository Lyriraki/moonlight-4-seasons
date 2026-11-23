<script lang="ts">
  // Svelte 5 sample: runes, props, events, conditions, loops
  import Header from "./Header.svelte";
  import { onMount } from "svelte";

  interface Props {
    title: string;
    max?: number;
  }

  let { title, max = 10 }: Props = $props();

  let count = $state(0);
  let items = $state<string[]>(["One", "Two", "Three"]);
  let doubled = $derived(count * 2);

  const API_URL = "https://example.com/api";

  function increment() {
    if (count < max) count += 1;
  }

  async function load(id: number): Promise<void> {
    const res = await fetch(`${API_URL}/items/${id}`);
    items = await res.json();
  }

  $effect(() => {
    console.log(`Current count: ${count}`, doubled);
  });

  onMount(() => load(1));
</script>

<Header {title} level={2} />

<main class="container" data-theme="dark">
  <h1>{title}</h1>
  <p>Count: {count} (doubled: {doubled})</p>

  <button onclick={increment} disabled={count >= max}>Add</button>

  {#if count === 0}
    <p>No clicks yet.</p>
  {:else if count < max}
    <p>Keep clicking!</p>
  {:else}
    <p>Maximum reached.</p>
  {/if}

  <ul>
    {#each items as item, i (item)}
      <li class:active={i === 0}>{i + 1}. {item}</li>
    {/each}
  </ul>

  <a href="/privacy/">Continue</a>
</main>

<style>
  .container {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    color: #c8d3f5;
  }

  li.active {
    font-weight: bold;
    color: var(--primary, #7c5cff);
  }

  button:hover:not(:disabled) {
    transform: scale(1.05);
  }
</style>
