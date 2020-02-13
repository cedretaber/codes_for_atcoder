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
    let mut mp = HashMap::new();
    for a in get!(String).split_whitespace().map(|n| n.parse::<usize>().unwrap()) {
        let v = mp.entry(a).or_insert(0);
        *v += 1;
    }
    let mut e = 0;
    let mut o = 0;
    for (_, n) in mp {
        if n%2 == 0 {
            e += 1;
        } else {
            o += 1;
        }
    }
    println!("{}", o + e/2*2);
}