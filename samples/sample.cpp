// C++ sample: class, template, lambda, STL
#include <algorithm>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

namespace shop {

constexpr int kMaxItems = 100;

template <typename T>
class Stack {
public:
    void push(const T &value) { items_.push_back(value); }

    T pop() {
        T top = items_.back();
        items_.pop_back();
        return top;
    }

    bool empty() const noexcept { return items_.empty(); }

private:
    std::vector<T> items_;
};

class Animal {
public:
    explicit Animal(std::string name) : name_(std::move(name)) {}
    virtual ~Animal() = default;
    virtual std::string speak() const { return name_ + " makes a sound"; }

protected:
    std::string name_;
};

class Dog final : public Animal {
public:
    using Animal::Animal;
    std::string speak() const override { return name_ + " barks"; }
};

}  // namespace shop

int main() {
    auto dog = std::make_unique<shop::Dog>("Rex");
    shop::Stack<int> stack;
    for (int i = 0; i < 5; ++i) stack.push(i * 2);

    std::vector<int> nums{5, 3, 8, 1};
    std::sort(nums.begin(), nums.end(), [](int a, int b) { return a > b; });

    std::cout << dog->speak() << " " << nums.front() << std::endl;
    return 0;
}
