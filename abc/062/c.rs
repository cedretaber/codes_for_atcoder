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
    let (h, w) = get!(usize, usize);
    if h%3 == 0 || w%3 == 0 {
        println!("{}", 0);
        return;
    }

    let mut res = cmp::min(h, w);
    for i in 1..h {
        let a = i * w;
        let b = (h-i) * (w/2);
        let c = (h-i) * ((w+1)/2);
        res = cmp::min(res, cmp::max(a, cmp::max(b, c)) - cmp::min(a, cmp::min(b, c)));
    }
    for i in 1..w {
        let a = i * h;
        let b = (w-i) * (h/2);
        let c = (w-i) * ((h+1)/2);
        res = cmp::min(res, cmp::max(a, cmp::max(b, c)) - cmp::min(a, cmp::min(b, c)));
    }

    println!("{}", res);
}