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
use std::collections::HashMap;

fn main() {
    let n = get!(usize);
    let az: Vec<char> = "abcdefghijklmnopqrstuvwxyz".chars().collect();
    let c2i = az.iter().cloned().enumerate().map(|(i, e)| (e, i)).collect::<HashMap<_, _>>();
    let mut chars = vec![50; 26];

    for _ in 0..n {
        let mut cs = vec![0; 26];
        for c in get!(String).chars() {
            if let Some(i) = c2i.get(&c) {
                cs[*i] += 1;
            }
        }
        for i in 0..26 {
            chars[i] = cmp::min(chars[i], cs[i]);
        }
    }
    let mut s = Vec::new();
    for (i, n) in chars.iter().enumerate() {
        for _ in 0..*n {
            s.push(az[i]);
        }
    }
    println!("{}", s.into_iter().collect::<String>());
}