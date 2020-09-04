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

use std::collections::HashMap;

fn main() {
    let _n = get!(usize);
    let aa = get!(String).split_whitespace().map(|a| a.parse::<usize>().unwrap()).collect::<Vec<_>>();

    let mut map = HashMap::new();
    for a in aa.into_iter() {
        let v = map.entry(a).or_insert(0);
        *v += 1;
    }

    let mut r = 0;
    for (k, v) in map {
        if v < k {
            r += v;
        } else {
            r += v - k;
        }
    }
    println!("{}", r);
}