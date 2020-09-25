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
    let (n, mut y) = get!(usize, usize);
    y /= 1000;
    for a in 0..n+1 {
        for b in 0..n+1 {
            if a+b > n { break; }
            let c = n - (a+b);
            if a*10 + b*5 + c == y {
                println!("{} {} {}", a, b, c);
                return;
            }
        }
    }
    println!("-1 -1 -1");
}