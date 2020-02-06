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
    let (n, a, b) = get!(usize, usize, usize);
    let xs = get!(String).split_whitespace().map(|s| s.parse::<usize>().unwrap()).collect::<Vec<_>>();
    let mut r: usize = 0;
    for i in 1..n {
        if b > (xs[i] - xs[i-1]) * a {
            r += (xs[i] - xs[i-1]) * a;
        } else {
            r += b;
        }
    }
    println!("{}", r);
}