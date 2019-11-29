use std::io;

fn main() {
    let mut buf1 = String::new();
    io::stdin().read_line(&mut buf1).unwrap();
    let a: usize = buf1.trim().parse().unwrap();

    let mut buf2 = String::new();
    io::stdin().read_line(&mut buf2).unwrap();
    let mut iter = buf2.split_whitespace();
    let b: usize = iter.next().unwrap().parse().unwrap();
    let c: usize = iter.next().unwrap().parse().unwrap();

    let mut s = String::new();
    io::stdin().read_line(&mut s).unwrap();

    println!("{} {}", a + b + c, s.trim());
}