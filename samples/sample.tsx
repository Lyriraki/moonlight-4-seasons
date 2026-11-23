// TSX sample: React component, hooks, typed props
import { useEffect, useMemo, useState, type ReactNode } from "react";
import { Button } from "./Button";

const API_URL = "https://example.com/api";

interface Todo {
  id: number;
  title: string;
  done: boolean;
}

interface ListProps {
  title: string;
  limit?: number;
  children?: ReactNode;
  onSelect: (todo: Todo) => void;
}

export function TodoList({ title, limit = 10, children, onSelect }: ListProps) {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [loading, setLoading] = useState(true);

  const remaining = useMemo(() => todos.filter((t: Todo) => !t.done).length, [todos]);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const res = await fetch(`${API_URL}/todos?limit=${limit}`);
      const data: Todo[] = await res.json();
      if (!cancelled) {
        setTodos(data);
        setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [limit]);

  if (loading) return <p className="text-gray-500">Loading...</p>;

  return (
    <section className="p-4 rounded-lg" data-testid="todo-list">
      <h2 className="text-xl font-bold">{title}</h2>
      <p>
        {remaining} of {todos.length} tasks remaining
      </p>
      <ul>
        {todos.map((todo) => (
          <li key={todo.id} style={{ opacity: todo.done ? 0.5 : 1 }}>
            <Button variant="ghost" onClick={() => onSelect(todo)}>
              {todo.title}
            </Button>
          </li>
        ))}
      </ul>
      {children}
      <a href="/privacy/">Continue</a>
    </section>
  );
}
