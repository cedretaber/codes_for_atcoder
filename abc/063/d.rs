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

fn main() {
    let (n, a, b) = get!(usize, i64, i64);
    let hs = get!(i64; n);

    let mut l = 0i64;
    let mut r = 1000000000i64;
    while l+1 < r {
        let m = (l+r)/2;
        let mut mm = 0;
        for h in hs.iter() {
            let hh = h - m * b;
            if hh > 0 {
                mm += (hh + (a-b) - 1) / (a-b);
            }
        }
        if mm <= m {
            r = m;
        } else {
            l = m;
        }
    }
    println!("{}", r);
}