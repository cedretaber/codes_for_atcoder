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
    let n = get!(usize);
    let a1 = get!(String).split_whitespace().map(|a| a.parse::<i32>().unwrap()).collect::<Vec<_>>();
    let a2 = get!(String).split_whitespace().map(|a| a.parse::<i32>().unwrap()).collect::<Vec<_>>();

    let mut r = 0;
    for x in 0..n {
        let mut s = 0;
        for i in 0..x+1 {
            s += a1[i];
        }
        for i in x..n {
            s += a2[i];
        }
        r = cmp::max(r, s);
    }
    println!("{}", r);
}