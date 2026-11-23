// TypeScript sample: interface, generics, enum, decorator
import type { Request, Response } from "express";

export enum Role {
  Admin = "admin",
  User = "user",
}

export interface Product {
  readonly id: number;
  name: string;
  price: number;
  tags?: string[];
}

type Result<T> = { ok: true; data: T } | { ok: false; error: string };

const DEFAULT_LIMIT = 20 as const;

export class Repository<T extends { id: number }> {
  private items = new Map<number, T>();

  constructor(private readonly name: string) {}

  save(item: T): void {
    this.items.set(item.id, item);
  }

  find(id: number): T | undefined {
    return this.items.get(id);
  }

  findAll(limit: number = DEFAULT_LIMIT): T[] {
    return [...this.items.values()].slice(0, limit);
  }
}

export function parse<T>(raw: string): Result<T> {
  try {
    return { ok: true, data: JSON.parse(raw) as T };
  } catch (e) {
    return { ok: false, error: `Invalid JSON: ${(e as Error).message}` };
  }
}

export const handler = async (req: Request, res: Response): Promise<void> => {
  const repo = new Repository<Product>("products");
  repo.save({ id: 1, name: "Coffee", price: 15000 });
  res.status(200).json(repo.findAll());
};
