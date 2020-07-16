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
    let (n, k) = get!(usize, usize);
    let mut xx = Vec::new();
    let mut yy = Vec::new();
    for _ in 0..n {
        let (x, y) = get!(i64, i64);
        xx.push(x);
        yy.push(y);
    }

    let mut a = i64::max_value();
    for t in 0..n {
        for b in 0..n {
            if yy[t] - yy[b] <= 0 { continue; }
            for l in 0..n {
                for r in 0..n {
                    if xx[r] - xx[l] <= 0 { continue; }
                    let mut kk = 0;
                    for i in 0..n {
                        if yy[b] <= yy[i] && yy[i] <= yy[t] && xx[l] <= xx[i] && xx[i] <= xx[r] {
                            kk += 1;
                        }
                    }
                    if kk == k {
                        a = cmp::min(a, (yy[t] - yy[b]) * (xx[r] - xx[l]));
                    }
                }
            }
        }
    }
    println!("{}", a);
}