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

const P: i64 = 1000000007;

fn main() {
    let (n, m) = get!(i64, i64);
    let d = (n-1) * (m-1) % P;

    let xs = get!(String).split_whitespace().map(|n| n.parse::<i64>().unwrap()).collect::<Vec<_>>();
    let ys = get!(String).split_whitespace().map(|n| n.parse::<i64>().unwrap()).collect::<Vec<_>>();
}