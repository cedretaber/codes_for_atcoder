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
    let mut ll = HashMap::new();
    for c in get!(String).split_whitespace() {
        let a = c.parse::<i64>().unwrap();
        let e = ll.entry(a).or_insert(0);
        *e += 1;
    }
    let mut kk = ll.keys().collect::<Vec<_>>();
    kk.sort();
    kk.reverse();
    let mut l = 0;
    for k in kk.into_iter() {
        if ll[k] >= 2 {
            if l == 0 {
                if ll[k] >= 4 {
                    println!("{}", k * k);
                    return;
                }
                l = *k;
            } else {
                println!("{}", l * k);
                return;
            }
        }
    }
    println!("0");
}