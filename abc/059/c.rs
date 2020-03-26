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

fn solve(mut i: i64, aa: Vec<i64>) -> i64 {
    let mut x = 0;
    let mut s = 0;
    for &a in aa.iter() {
        s += a;
        if (s < 0 && i > 0) || (s > 0 && i < 0) {
            x += -1*s*i + 1;
            s = i;
        } else if s == 0 {
            x += 1;
            s = i;
        }
        i = if i == -1 { 1 } else { -1 };
    }
    return x;
}

fn main() {
    let _n = get!(i64);
    let aa: Vec<i64> = get!(String).split_whitespace().map(|a| a.parse().unwrap()).collect();
    println!("{}", cmp::min(solve(1, aa.clone()), solve(-1, aa)));
}