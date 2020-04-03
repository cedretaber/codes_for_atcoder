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
    let (_n, tt) = get!(usize, i64);
    let ts = get!(String).split_whitespace().map(|t| t.parse::<i64>().unwrap()).collect::<Vec<_>>();
    let mut l = 0;
    let mut r = tt;
    let mut s = 0;
    for &t in ts[1..].into_iter() {
        if r >= t {
            r = t + tt;
        } else {
            s += r - l;
            l = t;
            r = t + tt;
        }
    }
    println!("{}", s + r - l);
}