// Scala 3 sample: case class, trait, enum, pattern matching
package com.example.shop

import scala.collection.mutable.ListBuffer
import scala.util.{Failure, Success, Try}

val MaxItems = 100

enum Status:
  case Pending, Paid, Shipped

case class Product(id: Int, name: String, price: Double = 0.0)

trait Describable:
  def describe: String
  def shout: String = describe.toUpperCase

class Cart(val owner: String) extends Describable:
  private val items = ListBuffer.empty[Product]

  def add(product: Product): this.type =
    items += product
    this

  def total: Double = items.map(_.price).sum

  override def describe: String =
    s"$owner's cart has ${items.size} items, total ${total}"

object Cart:
  def apply(owner: String): Cart = new Cart(owner)

  def parse(text: String): Try[Int] = Try(text.trim.toInt)

def label(status: Status): String = status match
  case Status.Pending => "Pending"
  case Status.Paid    => "Paid"
  case Status.Shipped => "Shipped"

@main def run(): Unit =
  val cart = Cart("Alex").add(Product(1, "Coffee", 15000.0))
  println(cart.describe)
  Cart.parse("42") match
    case Success(n) if n > 0 => println(s"Valid number: $n")
    case Success(_)          => println("Not positive")
    case Failure(e)          => println(s"Error: ${e.getMessage}")
  val doubled = List(1, 2, 3).map(x => x * 2).filter(_ > 2)
  println(label(Status.Paid) + " " + doubled)
