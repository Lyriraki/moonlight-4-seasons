// C# sample: class, interface, LINQ, async
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Shop
{
    public interface IGreeter
    {
        string Greet(string name);
    }

    public record Product(int Id, string Name, decimal Price);

    public class Cart : IGreeter
    {
        private const int MaxItems = 100;
        private readonly List<Product> _items = new();

        public int Count => _items.Count;
        public string Owner { get; set; } = "Anonymous";

        public void Add(Product product)
        {
            if (_items.Count >= MaxItems)
                throw new InvalidOperationException("Cart is full");
            _items.Add(product);
        }

        public decimal Total() => _items.Sum(p => p.Price);

        public string Greet(string name) => $"Hello, {name}! Total: {Total():C}";

        public async Task<string> LoadAsync(string url)
        {
            await Task.Delay(100);
            return @"C:\data\file.txt";
        }
    }

    internal static class Program
    {
        private static async Task Main(string[] args)
        {
            var cart = new Cart { Owner = "Alex" };
            cart.Add(new Product(1, "Coffee", 15000m));
            var names = cart.Count > 0 ? "some" : "none";
            Console.WriteLine(cart.Greet(names));
            Console.WriteLine(await cart.LoadAsync("http://x.io"));
        }
    }
}
