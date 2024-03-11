// Rust program for converting decimal to hexadecimal
fn main() {
    let decimal_number = 42;
    let hexadecimal_string = format!("{:X}", decimal_number);
    println!("Decimal {} is equivalent to hexadecimal {}", decimal_number, hexadecimal_string);
}