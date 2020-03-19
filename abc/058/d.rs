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

    let xs = get!(String).split_whitespace().map(|n| n.parse::<i64>().unwrap()).collect::<Vec<_>>();
    let ys = get!(String).split_whitespace().map(|n| n.parse::<i64>().unwrap()).collect::<Vec<_>>();

    let mut x = 0;
    let mut y = 0;
    for i in 0..n-1 { x = (x + (xs[(i+1) as usize] - xs[i as usize]) * (i+1) % P * (n-i-1)) % P; }
    for i in 0..m-1 { y = (y + (ys[(i+1) as usize] - ys[i as usize]) * (i+1) % P * (m-i-1)) % P; }
    println!("{}", x * y % P);
}