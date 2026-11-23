"""Python sample: class, function, decorator, f-string."""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from typing import Optional

MAX_RETRY = 3
PATTERN = re.compile(r"^(?P<name>\w+)@(?P<host>[\w.]+)$")


@dataclass
class User:
    name: str
    age: int = 0
    tags: list[str] = field(default_factory=list)

    @property
    def is_adult(self) -> bool:
        return self.age >= 18

    def greet(self, other: Optional["User"] = None) -> str:
        # Greet the other user if there is one
        if other is None:
            return f"Hello, {self.name}! You are {self.age} years old."
        return "Hello {0}, I am {1}".format(other.name, self.name)


def fibonacci(n: int) -> list[int]:
    result, a, b = [], 0, 1
    while len(result) < n:
        result.append(a)
        a, b = b, a + b
    return result


async def fetch(url: str, *, retry: int = MAX_RETRY) -> dict | None:
    for attempt in range(retry):
        try:
            print(f"Attempt {attempt + 1}: {url!r}")
            return {"ok": True, "size": 0x1F, "ratio": 3.14e-2}
        except (ValueError, KeyError) as err:
            print(err)
    return None


if __name__ == "__main__":
    user = User("Alex", 21, tags=["admin", "dev"])
    print(user.greet(), [x * 2 for x in fibonacci(8) if x % 2 == 0])
