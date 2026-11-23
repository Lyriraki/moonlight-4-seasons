<?php
declare(strict_types=1);

namespace App\Models;

use InvalidArgumentException;

// PHP sample: class, trait, interface, closure
interface Describable
{
    public function describe(): string;
}

abstract class Model implements Describable
{
    protected static int $count = 0;
    public const TABLE = "models";

    public function __construct(
        protected int $id,
        protected string $name = "unnamed",
    ) {
        static::$count++;
    }

    abstract public function save(): bool;
}

final class User extends Model
{
    private array $roles = ["user", "guest"];

    public function describe(): string
    {
        return sprintf("User #%d: %s", $this->id, $this->name);
    }

    public function save(): bool
    {
        if (empty($this->name)) {
            throw new InvalidArgumentException("Name is required");
        }
        echo "Saving {$this->name} to " . self::TABLE . "\n";
        return true;
    }
}

$user = new User(1, "Alex");
$double = fn(int $n): int => $n * 2;
$result = array_map($double, [1, 2, 3.5, 0x1f]);
echo $user->describe() . " " . implode(",", $result);
