//! Rust sample: struct, trait, enum, generics, lifetime
use std::collections::HashMap;
use std::fmt;

const MAX_ITEMS: usize = 100;

#[derive(Debug, Clone, PartialEq)]
pub enum Status {
    Pending,
    Paid { amount: f64 },
    Failed(String),
}

#[derive(Debug)]
pub struct Order<'a> {
    pub id: u32,
    pub name: &'a str,
    items: Vec<(String, u32)>,
}

pub trait Describe {
    fn describe(&self) -> String;
}

impl<'a> Order<'a> {
    pub fn new(id: u32, name: &'a str) -> Self {
        Self { id, name, items: Vec::new() }
    }

    pub fn add(&mut self, item: &str, qty: u32) -> &mut Self {
        self.items.push((item.to_string(), qty));
        self
    }
}

impl Describe for Order<'_> {
    fn describe(&self) -> String {
        format!("Order #{} for {} ({} items)", self.id, self.name, self.items.len())
    }
}

impl fmt::Display for Status {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            Status::Pending => write!(f, "pending"),
            Status::Paid { amount } => write!(f, "paid {:.2}", amount),
            Status::Failed(why) => write!(f, "failed: {why}"),
        }
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut order = Order::new(1, "Alex");
    order.add("coffee", 2).add("tea", 1);
    let mut stock: HashMap<&str, i32> = HashMap::new();
    stock.insert("coffee", 0xFF);
    println!("{}", order.describe());
    if let Some(n) = stock.get("coffee") {
        println!("stock = {n}, status = {}", Status::Paid { amount: 3.5 });
    }
    Ok(())
}
