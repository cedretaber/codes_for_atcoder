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
        ).collect::<Vec<_>>()
    };
    ($t:ty ;;) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.split_whitespace()
                .map(|t| t.parse::<$t>().unwrap())
                .collect::<Vec<_>>()
        }
    };
    ($t:ty ;; $n:expr) => {
        (0..$n).map(|_| get!($t ;;)).collect::<Vec<_>>()
    };
}

#[derive(Hash, Eq, PartialEq, Debug)]
struct P {
    x: usize,
    y: usize
}

use std::collections::HashMap;

fn main() {
    let (h, w, n) = get!(usize, usize, usize);
    let mut ps = HashMap::new();
    for _ in 0..n {
        let (a, b) = get!(usize, usize);
        for y in a-1 .. a+2 {
            for x in b-1 .. b+2 {
                if 1 < x && x < w && 1 < y && y < h {
                    *ps.entry(P { x: x, y: y }).or_insert(0) += 1;
                }
            }
        }
    }
    let mut rs = vec![0; 10];
    let mut c = 0;
    for (_, n) in ps {
        c += 1;
        rs[n] += 1;
    }
    rs[0] = (h-2) * (w-2) - c;
    for r in rs { println!("{}", r) }
}