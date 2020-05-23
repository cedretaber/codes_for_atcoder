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
    let aa = get!(String).split_whitespace().map(|i| i.parse::<i64>().unwrap()).collect::<Vec<_>>();
    let mut ll = vec![0; n];
    ll[0] = aa[0];
    let mut rr = vec![0; n];
    rr[n-1] = aa[n-1];
    for i in 1..n {
        ll[i] = ll[i-1] + aa[i];
        let j = n - i - 1;
        rr[j] = rr[j+1] + aa[j];
    }
    let mut r = i64::max_value();
    for i in 0..n-1 {
        r = cmp::min(r, (ll[i] - rr[i+1]).abs());
    }
    println!("{}", r);
}