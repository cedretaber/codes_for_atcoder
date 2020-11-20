macro_rules! get {
    ($t:ty) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.trim().parse::<$t>().unwrap()
        }
    };
    ($($t:ty),*) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            let mut iter = line.split_whitespace();
            (
                $(iter.next().unwrap().parse::<$t>().unwrap(),)*
            )
        }
    };
    ($t:ty; $n:expr) => {
        (0..$n).map(|_|
            get!($t)
        ).collect::<Vec<_>>()
    };
    ($($t:ty),*; $n:expr) => {
        (0..$n).map(|_|
            get!($($t),*)
        ).collect::<Vec<_>>()å
    };
}

use std::collections::HashMap;
use std::cmp;

fn main() {
    let mut map = HashMap::new();
    let n = get!(usize);
    for _ in 0..n {
        let s = get!(String);
        let x = map.entry(s).or_insert(0);
        *x += 1;
    }
    let m = get!(usize);
    for _ in 0..m {
        let t = get!(String);
        let x = map.entry(t).or_insert(0);
        *x -= 1;
    }
    println!("{}", cmp::max(0, *map.values().max().unwrap()));
}