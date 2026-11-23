// JavaScript sample: class, async, template string, regex
import { readFile } from "node:fs/promises";

const API_URL = "https://example.com/api";
const MAX = 10;

/**
 * Calculates the total price.
 * @param {Array<{price: number, qty: number}>} items
 */
function total(items) {
  return items.reduce((sum, { price, qty }) => sum + price * qty, 0);
}

class Cart {
  #items = [];
  static count = 0;

  constructor(owner) {
    this.owner = owner;
    Cart.count++;
  }

  add(item) {
    this.#items.push(item);
    return this;
  }

  get size() {
    return this.#items.length;
  }

  toString() {
    return `${this.owner}'s cart: ${this.size} items`;
  }
}

const fetchUser = async (id) => {
  try {
    const res = await fetch(`${API_URL}/users/${id}`, { method: "GET" });
    if (!res.ok) throw new Error("Failed: " + res.status);
    const { name, email = null } = await res.json();
    return /^[\w.-]+@[\w.-]+$/.test(email) ? { name, email } : undefined;
  } catch (err) {
    console.error(err.message);
  } finally {
    console.log("done", 42, 3.14, true, null);
  }
};

const cart = new Cart("Alex").add({ price: 1500, qty: 2 });
console.log(String(cart), total([{ price: 10, qty: 3 }]));
