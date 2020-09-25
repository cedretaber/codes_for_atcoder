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
}

use std::cmp;

fn main() {
    let (n, mut h) = get!(usize, i64);
    let mut a_max = 0;
    let mut bs = Vec::new();
    for _ in 0..n {
        let (a, b) = get!(i64, i64);
        a_max = cmp::max(a_max, a);
        bs.push(b);
    }
    bs.sort_by(|a, b| b.cmp(a));
    let mut r = 0;
    for b in bs.into_iter() {
        if a_max >= b {
            println!("{}", r + (h + a_max - 1) / a_max);
            return;
        }
        h -= b;
        r += 1;
        if h <= 0 {
            println!("{}", r);
            return;
        }
    }
    println!("{}", r + (h + a_max - 1) / a_max);
}