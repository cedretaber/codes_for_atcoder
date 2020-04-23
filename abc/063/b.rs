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
    let s = get!(String).chars().collect::<Vec<_>>();
    let mut m = HashMap::new();
    for c in s.into_iter() {
        let v = m.entry(c).or_insert(0);
        *v += 1;
    }
    for (_, v) in m {
        if v > 1 {
            println!("no");
            return;
        }
    }
    println!("yes");
}